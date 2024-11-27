import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:robu/themes/app_theme.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Robust extends StatefulWidget {
  const Robust({Key? key}) : super(key: key);

  @override
  State<Robust> createState() => _RobustState();
}

class _RobustState extends State<Robust> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final YoutubeExplode _youtubeExplode = YoutubeExplode();
  final PanelController _panelController = PanelController();

  List<dynamic> _videos = [];
  int _currentVideoIndex = -1;
  String? _currentThumbnail;
  String? _currentVideoName;
  bool _isPlaying = false;
  bool _isLoading = true;
  Color _backgroundColor = Color(0xff15292f); // Default background color :)
  bool _isPanelExpanded = false;

  @override
  void initState() {
    super.initState();
    _fetchVideos();
    _audioPlayer.playerStateStream.listen((state) {
      setState(() {
        _isPlaying = state.playing;
      });
    });
  }

  Future<void> _fetchVideos() async {
    const String jsonUrl =
        "https://onnesok.github.io/Host-api-dev/podcast.json";
    try {
      final response = await http.get(Uri.parse(jsonUrl));
      if (response.statusCode == 200) {
        setState(() {
          _videos = json.decode(response.body);
          _isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching videos: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _playAudio(
      String url, String videoName, String? thumbnail) async {
    try {
      final videoId = VideoId(url);
      final manifest =
          await _youtubeExplode.videos.streamsClient.getManifest(videoId);
      final audioStreamInfo = manifest.audioOnly.withHighestBitrate();

      if (audioStreamInfo != null) {
        setState(() {
          _isLoading = true;
        });
        await _audioPlayer.setUrl(audioStreamInfo.url.toString());
        _audioPlayer.play();

        setState(() {
          _currentThumbnail = thumbnail;
          _currentVideoName = videoName;
          _isLoading = false;
        });

        // Extract dominant color from thumbnail and update background color
        // if (thumbnail != null) {
        //   _extractDominantColor(thumbnail);
        // }

        if (_panelController.isAttached && !_panelController.isPanelOpen) {
          _panelController.open();
        }
      } else {
        print("Audio stream is not available.");
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print("Error playing audio: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }


  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  // Method to handle when the panel is fully opened
  void _onPanelOpened() {
    setState(() {
      _isPanelExpanded = true;
    });
  }

  // Method to handle when the panel is closed
  void _onPanelClosed() {
    setState(() {
      _isPanelExpanded = false;
    });
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
      backgroundColor: AppTheme.white,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        title: Text("Robust", style: TextStyle(color: Colors.black87)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              "Welcome to ROBU Podcast (ROBUST)",
              style: AppTheme.body1,
            ),
          ),
          Expanded(
            child: SlidingUpPanel(
              controller: _panelController,
              minHeight: 130,
              maxHeight: MediaQuery.of(context).size.height,
              // Full screen height
              color: Colors.transparent,
              onPanelOpened: _onPanelOpened,
              // Detect when panel is fully expanded
              onPanelClosed: _onPanelClosed,
              // Detect when panel is closed
              panel: _buildPodcastPlayer(),
              body: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.blue),
                    )
                  : ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16).copyWith(bottom: 230),
                itemCount: _videos.length,
                itemBuilder: (context, index) {
                  final video = _videos[index];
                  return Column(
                    children: [
                      Card(
                        color: AppTheme.nearlyWhite,
                        margin: const EdgeInsets.symmetric(vertical: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12),
                          leading: SizedBox(
                            width: 60,
                            height: 60,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                video["thumbnail"],
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded /
                                          (loadingProgress.expectedTotalBytes ?? 1)
                                          : null,
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  // Dummy image icon when image fails to load... handled :D
                                  return Icon(
                                    Icons.image_not_supported,
                                    size: 60,
                                    color: Colors.grey,
                                  );
                                },
                              ),
                            ),
                          ),
                          title: Text(
                            video["videoName"],
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          onTap: () {
                            _currentVideoIndex = index;
                            _playAudio(video["youtubeLink"], video["videoName"], video["thumbnail"]);
                          },
                        ),
                      ),
                      // Divider-like line
                      Divider(
                        color: Colors.blueAccent.withOpacity(0.3),
                        thickness: 1,
                        indent: 80,
                        endIndent: 16,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPodcastPlayer() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_backgroundColor, _backgroundColor.withOpacity(0.7)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            if (_isPanelExpanded && _currentThumbnail != null)
              Padding(
                padding: const EdgeInsets.only(
                    top: 60,
                    bottom: 16.0,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    _currentThumbnail!,
                    height: 250,
                    width: 250,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            Text(
              _currentVideoName ?? "Nothing playing",
              style: AppTheme.title.copyWith(color: Colors.white, fontSize: 22),
              textAlign: TextAlign.center,
            ),
            _isPanelExpanded ? Padding(
              padding: const EdgeInsets.all(16),
              child: Text("PODCAST", style: AppTheme.body_grey.copyWith(letterSpacing: 2),),
            ) : SizedBox(height: 0,),
            const SizedBox(height: 8),
            StreamBuilder<Duration>(
              stream: _audioPlayer.positionStream,
              builder: (context, snapshot) {
                final position = snapshot.data ?? Duration.zero;
                final duration = _audioPlayer.duration ?? Duration.zero;
                return Column(
                  children: [
                    Slider(
                      value: position.inSeconds.toDouble(),
                      max: duration.inSeconds.toDouble(),
                      activeColor: Colors.white,
                      inactiveColor: Colors.white54,
                      thumbColor: Colors.blueAccent,
                      onChanged: (value) {
                        _audioPlayer.seek(Duration(seconds: value.toInt()));
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formatDuration(position),
                            style: const TextStyle(color: Colors.white),
                          ),
                          Text(
                            _formatDuration(duration),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.skip_previous,
                      color: Colors.white, size: 30),
                  onPressed: () {
                    if (_currentVideoIndex > 0) {
                      _currentVideoIndex--;
                      _playAudio(
                          _videos[_currentVideoIndex]["youtubeLink"],
                          _videos[_currentVideoIndex]["videoName"],
                          _videos[_currentVideoIndex]["thumbnail"]);
                    }
                  },
                ),
                IconButton(
                  icon: Icon(
                    _isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    if (_isPlaying) {
                      _audioPlayer.pause();
                    } else {
                      _audioPlayer.play();
                    }
                  },
                ),
                IconButton(
                  icon:
                      const Icon(Icons.skip_next, color: Colors.white, size: 30),
                  onPressed: () {
                    if (_currentVideoIndex < _videos.length - 1) {
                      _currentVideoIndex++;
                      _playAudio(
                          _videos[_currentVideoIndex]["youtubeLink"],
                          _videos[_currentVideoIndex]["videoName"],
                          _videos[_currentVideoIndex]["thumbnail"]);
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
