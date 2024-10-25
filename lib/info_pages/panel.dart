import 'package:flutter/material.dart';
import 'package:robu/themes/app_theme.dart';
import 'package:robu/url%20launcher/url_launcher.dart';
import 'dart:ui';

class Panel extends StatefulWidget {
  const Panel({Key? key}) : super(key: key);

  @override
  State<Panel> createState() => _PanelState();
}

class _PanelState extends State<Panel> {
  final List<Profile> profiles = [
    Profile(
      name: "Sajid Sohan",
      position: "President",
      imageUrl: 'assets/panel24/president.png',
      description: "Details",
      facebookUrl: 'https://www.facebook.com/sajid.sohan100700',
      linkedInUrl: '#',
    ),
    Profile(
      name: "S M Minoor Karim",
      position: "Vice President",
      imageUrl: 'assets/panel24/vice_president.png',
      description: "Details",
      facebookUrl: 'https://www.facebook.com/Minoor01',
      linkedInUrl: '#',
    ),
    Profile(
      name: "Ahmed Mahdi Uddin",
      position: "General Secretary of Operations",
      imageUrl: 'assets/panel24/secretary.png',
      description: "Details",
      facebookUrl: 'https://www.facebook.com/mahdi.ahmed.3388',
      linkedInUrl: '#',
    ),
    Profile(
      name: "Umama Tasnuva Aziz",
      position: "General Secretary of Administration",
      imageUrl: 'assets/panel24/general_secretary.png',
      description: "Details",
      facebookUrl: 'https://www.facebook.com/aziz.umtsv',
      linkedInUrl: '#',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        title: Text("Panel info", style: TextStyle(color: Colors.black87)),
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 20, bottom: 30),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/ui/background.png'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child: Text("Meet our\nLeadership",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Roboto-medium",
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/ui/b5.png'
                    ),
                    fit: BoxFit.fill,
                  ),
                ),

                child: ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: profiles.length,
                  separatorBuilder: (context, index) => SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    final profile = profiles[index];
                    return ProfileTile(profile: profile);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Profile {
  final String name;
  final String position;
  final String imageUrl;
  final String description;
  final String facebookUrl;
  final String linkedInUrl;

  Profile({
    required this.name,
    required this.position,
    required this.imageUrl,
    required this.description,
    required this.facebookUrl,
    required this.linkedInUrl,
  });
}

class ProfileTile extends StatelessWidget {
  final Profile profile;

  ProfileTile({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => print("Profile tile tapped: ${profile.name}"),
        child: Container(
          margin: const EdgeInsets.only(left: 10, top: 4, bottom: 4, right: 10),
          padding: const EdgeInsets.only(top: 4, bottom: 4, left: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white.withOpacity(0.1),
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(profile.imageUrl),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          profile.name,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          profile.position,
                          style: TextStyle(fontSize: 12, color: Colors.black87),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.facebook),
                              color: Colors.blue,
                              onPressed: () => abouturl(Uri.parse(profile.facebookUrl)),
                            ),
                            IconButton(
                              icon: Icon(Icons.link),
                              color: Colors.blue,
                              onPressed: () => abouturl(Uri.parse(profile.linkedInUrl)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
