import 'package:flutter/material.dart';
import 'package:robu/Drawer_menu/about_screen.dart';
import 'package:robu/info_pages/alumni.dart';
import 'package:robu/info_pages/blood_bank.dart';
import 'package:robu/info_pages/bor.dart';
import 'package:robu/info_pages/robust.dart';
import 'package:robu/info_pages/panel.dart';
import 'package:robu/login/registration.dart';
import 'lists.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoHome extends StatefulWidget {
  const InfoHome({
    required this.callBack,
    Key? key,
  }) : super(key: key);

  final Function() callBack;

  @override
  State<InfoHome> createState() => _InfoHomeState();
}

class _InfoHomeState extends State<InfoHome> with TickerProviderStateMixin {
  late final AnimationController animationController;
  Future<void>? _launched;

  void navigateTo(Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  Future<void> _Bor(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
      webViewConfiguration: const WebViewConfiguration(
          headers: <String, String>{'my_header_key': 'my_header_value'}),
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  void _onInfoUiPressed(InfoBlock info_ui) {
    final Uri robuWeb = Uri(scheme: 'https', host: 'www.bracurobu.com');

    final List<String> videoIds = [
      'wfVmTObWe_k',
      'SbjwXnaIAxk',
      'TMxtvCgdz7k',
      "SQANb88NyTg",
      "InH5y6Nn2ik",
      "WlNC6biRQ6M",
      "KIDrfwxzWW4",
      "tJJ8mavtbFk",
      "onCcP5eCmxQ",
      "SiwbL-Vkf9k",
      "dEd6FAvWKgI"
    ];
    final List<String> videoTitles = [
      'Tutorial on Arduino',
      'Tutorial on Ultrasonic Sensor',
      'Tutorial on Single Channel Relay',
      "Tutorial on MQ 2 Gas sensor",
      "Tutorial on LED Blink using Analogue write and LED Fade",
      "Tutorial on Led blink using Digital write",
      "Tutorial on Jumper Wire",
      "Tutorial on Buzzer",
      "Tutorial on HC 05 Bluetooth Module",
      "Tutorial on IR sensor",
      "Tutorial on Breadboard Explanation"
    ];

    if (info_ui.title == 'Basic of robotics') {
      navigateTo(
        Bor(
            title: "Basic Of Robotics",
            image: "assets/ui/robot1.png",
            instructorName: "Robu",
            duration: "TBA",
            releaseDate: "TBA",
            videoContent: videoIds.join(','),
            description: "Join us for an immersive workshop designed to introduce participants to the fundamental concepts of robotics. This workshop is tailored for members of the Robotics Club of BRAC University, providing hands-on experience in various aspects of robotics.",
            videoTitle: videoTitles.join(","),
            prerequisite: "Become Robu Member"
        ),
      );
    } else if (info_ui.title == 'Robust') {
      navigateTo(Robust());
    } else if (info_ui.title == 'Blood bank') {
      navigateTo(BloodBank());
    } else if (info_ui.title == 'panel') {
      navigateTo(Panel());
    } else if (info_ui.title == 'Registration') {
      navigateTo(registration());
    } else if (info_ui.title == 'Announcements') {
      _launched = _Bor(robuWeb);
    } else if (info_ui.title == 'Alumni') {
      navigateTo(Alumni());
    } else if (info_ui.title == "About Robu") {
      navigateTo(AboutScreen());
    }
  }

  // Info grid code
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return GridView.builder(
                    shrinkWrap: true, // Ensures GridView fits within its parent
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 12.0,
                      crossAxisSpacing: 12.0,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: InfoBlock.InfoList.length,
                    itemBuilder: (context, index) {
                      final int count = InfoBlock.InfoList.length;
                      final Animation<double> animation = Tween<double>(
                        begin: 0.0,
                        end: 1.0,
                      ).animate(
                        CurvedAnimation(
                          parent: animationController,
                          curve: Interval((1 / count) * index, 1.0,
                              curve: Curves.fastOutSlowIn),
                        ),
                      );
                      animationController.forward();

                      return InfoUi(
                        callback: widget.callBack,
                        info_ui: InfoBlock.InfoList[index],
                        animation: animation,
                        animationController: animationController,
                        onPressed: () =>
                            _onInfoUiPressed(InfoBlock.InfoList[index]),
                      );
                    },
                  );
                },
              ),
            ],
          );
        }
      },
    );
  }
}

class InfoUi extends StatelessWidget {
  const InfoUi({
    required this.info_ui,
    required this.animationController,
    required this.animation,
    required this.callback,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final VoidCallback callback;
  final VoidCallback onPressed;
  final InfoBlock info_ui;
  final AnimationController animationController;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, _) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation.value), 0.0),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                onTap: () {
                  onPressed();
                  callback();
                },
                child: Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Expanded(
                          child: Ink(
                            decoration: BoxDecoration(
                              color: Colors.white70,
                              borderRadius:
                              const BorderRadius.all(Radius.circular(16.0)),
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.3)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16.0)),
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: Image.asset(info_ui.imagePath),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    info_ui.title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      fontFamily: "WorkSans",
                                      color: Colors.black87.withOpacity(0.7),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
