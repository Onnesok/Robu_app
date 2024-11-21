import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:just_audio/just_audio.dart';

class Robust extends StatefulWidget {
  const Robust({Key? key}) : super(key: key);

  @override
  State<Robust> createState() => _RobustState();
}

class _RobustState extends State<Robust> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final YoutubeExplode _youtubeExplode = YoutubeExplode();
  String? _status;
  bool _isPlaying = false;
  double _currentPosition = 0;
  double _audioDuration = 1;
  String? _thumbnailUrl;
  int _currentVideoIndex = -1; // Setting to -1 to indicate no video is selected initially
  List<dynamic> _videos = [];

  // Keep track of play status for each video
  List<bool> _isVideoPlaying = [];
  List<bool> _isLoading = [];

  @override
  void initState() {
    super.initState();
    _fetchVideos();
    _audioPlayer.playerStateStream.listen((state) {
      if (state.playing) {
        setState(() {
          _isPlaying = true;
        });
      } else {
        setState(() {
          _isPlaying = false;
        });
      }
    });
  }

  Future<void> _fetchVideos() async {
    const String jsonUrl = "https://onnesok.github.io/Host-api-dev/podcast.json";
    try {
      final response = await http.get(Uri.parse(jsonUrl));
      if (response.statusCode == 200) {
        setState(() {
          _videos = json.decode(response.body);
          // Initialize the play status for each video
          _isVideoPlaying = List.generate(_videos.length, (index) => false);
          // Initialize the loading state for each video
          _isLoading = List.generate(_videos.length, (index) => false);
        });
      } else {
        throw Exception("Failed to load videos");
      }
    } catch (e) {
      setState(() {
        _status = "Error: $e";
      });
    }
  }

  Future<void> _playAudio(String url, {bool updateIndex = false}) async {
    setState(() {
      _status = "Loading...";
      _isLoading[_currentVideoIndex] = true;
    });

    try {
      if (url.isEmpty) {
        throw Exception("Invalid YouTube URL");
      }

      final videoId = VideoId(url);

      // Fetch video details and thumbnail
      final video = await _youtubeExplode.videos.get(videoId);
      setState(() {
        _thumbnailUrl = video.thumbnails.highResUrl;
      });

      final manifest = await _youtubeExplode.videos.streamsClient.getManifest(videoId);
      final audioStreamInfo = manifest.audioOnly.withHighestBitrate();

      if (audioStreamInfo == null) {
        throw Exception("No audio stream found");
      }

      await _audioPlayer.setUrl(audioStreamInfo.url.toString());
      _audioPlayer.play();

      _audioPlayer.durationStream.listen((duration) {
        setState(() {
          _audioDuration = duration?.inSeconds.toDouble() ?? 1;
        });
      });

      _audioPlayer.positionStream.listen((position) {
        setState(() {
          _currentPosition = position.inSeconds.toDouble();
        });
      });

      if (updateIndex) {
        setState(() {
          _status = "${_videos[_currentVideoIndex]["videoName"]}...";
          _isVideoPlaying[_currentVideoIndex] = true;
          _isLoading[_currentVideoIndex] = false;
        });
      }
    } catch (e) {
      setState(() {
        _status = "Error: ${e.toString()}";
        _isLoading[_currentVideoIndex] = false;
      });
    }
  }

  void _pauseAudio() {
    _audioPlayer.pause();
    setState(() {
      _isPlaying = false;
      if (_currentVideoIndex != -1) {
        _isVideoPlaying[_currentVideoIndex] = false;
      }
    });
  }

  void _seekAudio(int seconds) {
    final newPosition = _currentPosition + seconds;
    if (newPosition > 0 && newPosition < _audioDuration) {
      _audioPlayer.seek(Duration(seconds: newPosition.toInt()));
    }
  }

  void _nextAudio() {
    if (_currentVideoIndex < _videos.length - 1) {
      _currentVideoIndex++;
      _playAudio(_videos[_currentVideoIndex]["youtubeLink"], updateIndex: true);
    }
  }

  void _previousAudio() {
    if (_currentVideoIndex > 0) {
      _currentVideoIndex--;
      _playAudio(_videos[_currentVideoIndex]["youtubeLink"], updateIndex: true);
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _youtubeExplode.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("Robust", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        elevation: 2,
      ),
      body: _videos.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: _videos.length,
        itemBuilder: (context, index) {
          final video = _videos[index];
          final isCurrentCard = index == _currentVideoIndex;

          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentVideoIndex = index;
                      _playAudio(video["youtubeLink"], updateIndex: true);
                    });
                  },
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        video["thumbnail"],
                        fit: BoxFit.cover,
                        width: 60,
                        height: 60,
                      ),
                    ),
                    title: Text(
                      video["videoName"],
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    trailing: isCurrentCard
                        ? null // No play button if this is the currently playing card
                        : const Icon(Icons.play_arrow, color: Colors.blueAccent, size: 30),
                  ),
                ),
                if (isCurrentCard) ...[
                  const Divider(height: 1),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (_isLoading[index])
                              const CircularProgressIndicator(),
                              SizedBox(width: 20,),
                              Text(_status ?? "Playing..."),
                            // ClipRRect(
                            //   borderRadius: BorderRadius.circular(8),
                            //   child: Image.network(
                            //     _thumbnailUrl ?? video["thumbnail"],
                            //     width: 50,
                            //     height: 50,
                            //     fit: BoxFit.cover,
                            //   ),
                            // ),
                            // const SizedBox(width: 12),
                            // Expanded(
                            //   child: Text(
                            //     _status ?? "Playing...",
                            //     style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                            //     overflow: TextOverflow.ellipsis,
                            //   ),
                            // ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Slider(
                          value: _currentPosition,
                          max: _audioDuration,
                          activeColor: Colors.blueAccent,
                          inactiveColor: Colors.grey,
                          onChanged: (value) => _audioPlayer.seek(Duration(seconds: value.toInt())),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.skip_previous, size: 30),
                              color: Colors.blueAccent,
                              onPressed: _previousAudio,
                            ),
                            IconButton(
                              icon: const Icon(Icons.replay_10, size: 30),
                              color: Colors.blueAccent,
                              onPressed: () => _seekAudio(-10),
                            ),
                            IconButton(
                              icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow, size: 30),
                              color: Colors.blueAccent,
                              onPressed: () {
                                _isPlaying ? _pauseAudio() : _audioPlayer.play();
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.forward_10, size: 30),
                              color: Colors.blueAccent,
                              onPressed: () => _seekAudio(10),
                            ),
                            IconButton(
                              icon: const Icon(Icons.skip_next, size: 30),
                              color: Colors.blueAccent,
                              onPressed: _nextAudio,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
