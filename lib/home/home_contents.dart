import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:robu/info_pages/video_play_screen.dart';
import 'package:robu/user_data/profile_provider.dart';
import 'dart:ui';
import '../themes/app_theme.dart';
import 'banner_list_view.dart';
import 'package:robu/home/info_home.dart';

class HomeContents extends StatefulWidget {
  const HomeContents({super.key});

  @override
  State<HomeContents> createState() => _HomeContentsState();
}

class _HomeContentsState extends State<HomeContents> {

  final List<String> ArduinovideoIds = [
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
  final List<String> ArduinovideoTitles = [
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


  final List<String> GraphicsvideoIds = [
    '8idQl1vjRes',
    'jPo472Zpphs',
    'eD5PXwWFkLU',
    'va8ivjdD358',
    'VRiEhtVzVEg'
  ];
  final List<String> GraphicsvideoTitles = [
    'Basics of AI & PSo',
    'Advanced of AI & PS also Basics of XD ',
    '3D Modeling',
    'Motion Graphics',
    'Motion Graphics - Advanced'
  ];


  final List<String> EventsvideoIds = [
    'B_27REnx8aY',
    'DPZoAKiW1-U',
    '8Fhyo6ul730',
    "w27D1hJRQjs"
  ];
  final List<String> EventsvideoTitles = [
    'Robotics Activity',
    'Project Manifestation Spring 2K18 - Meet the Aurobot',
    'Project Manifestation Fall 17',
    "Joyjatra'50 Techfest Intro Video"
  ];

  void navigateTo(Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: appBar(),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/ui/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getBannerUI(context),
              getbuttonSection(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: getInfoSectionUI(context),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget appBar() {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return Center(
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            height: 100.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/ui/background.png'),
                fit: BoxFit.fitWidth,
              ),
              color: Colors.white.withOpacity(0.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8),
                  child: SizedBox(
                    width: AppBar().preferredSize.height - 8,
                    height: AppBar().preferredSize.height - 8,
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                          children: [
                            ClipOval(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.blue,
                                      Colors.lightBlueAccent
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.25),
                                      blurRadius: 8,
                                      offset: Offset(2, 4),
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.all(10),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      profileProvider.fullName,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text("${profileProvider.position ?? 'No position assigned'}"),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(right: 20, top: 20),
                          child: Transform.rotate(
                            angle: 0.3,
                            child: IconButton(
                              onPressed: () {
                                Fluttertoast.showToast(msg: "Coming soon");
                              },
                                icon: Icon(Icons.notifications_none_outlined),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getBannerUI(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        BannerListView(
          callBack: () {
            /* Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CourseInfoScreen(categoryType: categoryType)),
              ); */
          },
        ),
      ],
    );
  }

  Widget getbuttonSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(width: 16,),
            Text(
              "What's your favourite?",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                letterSpacing: 0.27,
                color: AppTheme.darkerText,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 20),
              buttonUi(
                text: 'Arduino',
                onPressed: () {
                  navigateTo(CourseVideo(
                      videoContent: ArduinovideoIds.join(","),
                      videoTitle: ArduinovideoTitles.join(","),
                  ),
                  );
                },
              ),
              SizedBox(width: 16),
              buttonUi(
                text: 'Graphics',
                onPressed: () {
                  navigateTo(
                    CourseVideo(
                    videoContent: GraphicsvideoIds.join(","),
                    videoTitle: GraphicsvideoTitles.join(","),
                  ),
                  );
                },
              ),
              SizedBox(width: 16),
              buttonUi(
                text: 'Events',
                onPressed: () {
                  navigateTo(
                    CourseVideo(
                      videoContent: EventsvideoIds.join(","),
                      videoTitle: EventsvideoTitles.join(","),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }




  Widget buttonUi({
    required String text,
    required VoidCallback onPressed,
  }) {
    return Container(
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          side: BorderSide(color: Colors.red),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }


}

Widget getInfoSectionUI(context) {
  return Padding(
    padding: const EdgeInsets.only(top: 0, left: 18, right: 16),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Info section',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            letterSpacing: 0.27,
            color: AppTheme.darkerText,
          ),
        ),
        InfoHome(
          callBack: () {},
        ),
        SizedBox(height: 50,),
      ],
    ),
  );
}
