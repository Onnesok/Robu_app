import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:robu/info_pages/video_play_screen.dart';
import 'package:robu/themes/app_theme.dart';
import '../api/api_root.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Bor extends StatefulWidget {
  final int courseId;
  final String title;
  final String image;
  final String stars;
  final String discount;
  final String instructorName;
  final String duration;
  final String releaseDate;
  final String videoContent;  /// video id here and separated with coma "," in string format.... cse110 er slice mar :v
  final String description;
  final String videoTitle;
  final String prerequisite;
  final int ratingCount;
  final String certificate;
  final String introVideo;

  const Bor({
    super.key,
    this.courseId = 0,
    required this.title,
    required this.image,
    this.stars = '5',
    this.discount = "No",
    required this.instructorName,
    required this.duration,
    required this.releaseDate,
    required this.videoContent,
    required this.description,
    required this.videoTitle,
    required this.prerequisite,
    this.ratingCount = 0000,
    this.certificate = "No",
    this.introVideo = "1ENiVwk8idM",
  });

  @override
  State<Bor> createState() => _BorState();
}



class _BorState extends State<Bor> with TickerProviderStateMixin {
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;

  late YoutubePlayerController _controller;
  late final AnimationController animationController;
  late final Animation<double> animation;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: widget.introVideo,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        showLiveFullscreenButton: false,
        enableCaption: false,
        loop: true,
        controlsVisibleAtStart: true,
      ),
    );
    _controller.addListener(() {
      if (_controller.value.isFullScreen) {
        SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
      } else {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
      }
      if (mounted) {
        setState(() {});
      }
    });

    animationController = AnimationController(duration: const Duration(milliseconds: 800), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    if (_controller.value.isFullScreen) {
      _controller.toggleFullScreenMode();
    }

    _controller.removeListener(() {});
    _controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    super.dispose();
  }

  Future<void> setData() async {
    animationController.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    if (mounted) {
      setState(() {
        opacity1 = 1.0;
      });
    }
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    if (mounted) {
      setState(() {
        opacity2 = 1.0;
      });
    }
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    if (mounted) {
      setState(() {
        opacity3 = 1.0;
      });
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppTheme.white,
      appBar: _controller.value.isFullScreen
          ? null
          : AppBar(
        title: Text(widget.title),
        backgroundColor: AppTheme.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (_controller.value.isFullScreen) {
            _controller.toggleFullScreenMode();
            return Future.value(false);
          }
          return Future.value(true);
        },
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  videoPlayer(),
                  // scrollable.
                  buildDescription("email"),
                  if (_controller.value.isFullScreen)
                    buildJoinCourse("email"),
                ],
              ),
            ),
            if (!_controller.value.isFullScreen)
              buildJoinCourse("email"),
          ],
        ),
      ),
    );
  }


  Widget videoPlayer() {
    return Container(
      width: double.infinity,
      height: _controller.value.isFullScreen
          ? MediaQuery.of(context).size.height
          : MediaQuery.of(context).size.height * 0.4,
      child: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: AppTheme.blueaccent,
        onReady: () {},
        width: double.infinity,
      ),
    );
  }

  Widget buildDescription(String email) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.4,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Course Title
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: Text(
                  widget.title,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    letterSpacing: 0.27,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Rating and Stars
              Row(
                children: [
                  Icon(Icons.star, color: Colors.orange, size: 20),
                  const SizedBox(width: 4),
                  Text(
                    widget.stars,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const Spacer(),
                  // Discount (will be removed)
                  Text(
                    "Learn Robotics",
                    style: AppTheme.title_green,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Course Details (Classes, Time, Seats)
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    getTimeBoxUI("Duration:", "${widget.duration}"),
                    getTimeBoxUI("Release Date:", "${widget.releaseDate}"),
                    getTimeBoxUI("Certificate:", "${widget.certificate}"),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Description
              AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: opacity2,
                child: Text(
                  widget.description,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 14,
                    letterSpacing: 0.27,
                    color: Colors.grey,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      offset: const Offset(4, 4),
                      spreadRadius: 10,
                      blurRadius: 24,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Instructor:",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.deepOrangeAccent,
                      ),
                    ),
                    Text(
                      " ${widget.instructorName}",
                      style: AppTheme.body_grey,
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      offset: const Offset(4, 4),
                      spreadRadius: 10,
                      blurRadius: 24,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Prerequisites",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.deepOrangeAccent,
                      ),
                    ),
                    Text(
                      " ${widget.prerequisite}",
                      style: AppTheme.body_grey,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      offset: const Offset(4, 4),
                      spreadRadius: 10,
                      blurRadius: 24,
                    ),
                  ],
                ),
                child: Image.asset(
                  widget.image,
                ),
              ),

              // Extra spacing to ensure the button stays at the bottom
              SizedBox(height: MediaQuery.of(context).padding.bottom + 100),
            ],
          ),
        ),
      ],
    );
  }


  Widget buildJoinCourse(String email) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0), // Slide from right to left
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
        child: AnimatedOpacity(
          key: ValueKey(2),
          duration: const Duration(milliseconds: 500),
          opacity: opacity3,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  offset: const Offset(0, 3),
                  spreadRadius: 4,
                  blurRadius: 10,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10, top: 10),
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 10,
                      backgroundColor: AppTheme.blueaccent.withOpacity(0.6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () async{
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CourseVideo(
                            videoContent: widget.videoContent,
                            videoTitle: widget.videoTitle,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'Start Course',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10, top: 10),
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 10,
                      backgroundColor: AppTheme.blueaccent.withOpacity(0.6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () async{
                      Fluttertoast.showToast(msg: "Not accepting students for offline class right now");
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget getTimeBoxUI(String text1, String txt2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                offset: const Offset(1.1, 1.1),
                spreadRadius: 6,
                blurRadius: 10.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                text1,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: Colors.orange,
                ),
              ),
              Text(
                txt2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
