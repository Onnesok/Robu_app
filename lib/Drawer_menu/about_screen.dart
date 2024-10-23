import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:robu/Drawer_menu/about_details/projects.dart';
import 'package:robu/Drawer_menu/about_details/about_lists.dart';


class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  Future<void>? _launched;

  Future<void> _abouturl(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final PageController _projectPageController = PageController(viewportFraction: 0.4);

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("About Robu", style: TextStyle(color: Colors.black87)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                child: PageView.builder(
                  itemCount: banners.length,
                  itemBuilder: (context, index) {
                    final banner = banners[index];
                    return Container(
                      margin:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: Offset(0, 4),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            banner.imagePath != null
                                ? Image.asset(
                              banner.imagePath!,
                              fit: BoxFit.cover,
                            )
                                : Container(color: Colors.grey),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.7),
                                  ],
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Robotics Club of Bracu !',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ],
                ),
                child: Text(
                  "Often referred to as ROBU, is a dynamic and innovative student organization based at BRAC University in Bangladesh. "
                      "ROBU is dedicated to exploring the exciting world of robotics, automation, and artificial intelligence."
                      " Through hands-on projects, workshops, and competitions, members of ROBU gain valuable practical experience in designing and building robots. "
                      "This club serves as a hub for like-minded individuals passionate about technology, fostering collaboration, and pushing the boundaries of what's possible in the field of robotics. "
                      "ROBU's commitment to innovation and creativity makes it a vibrant and inspiring community for aspiring engineers and tech enthusiasts.",
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    fontFamily: "Roboto",
                    letterSpacing: 1,
                    wordSpacing: 1,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    alignment: WrapAlignment.spaceAround,
                    children: projects
                        .sublist(0, projects.length - 1) // Exclude the last project
                        .map((project) => buildRoundedProjectButton(context, project))
                        .toList(),
                  ),
                ),
              ),
              ///////////////////////////// Departments Section  /////////////////////////////////
              ListView.builder(
                padding: EdgeInsets.all(16.0),
                itemCount: departments.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final department = departments[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: Offset(0, 4),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        if (department.imagePath != null)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child:Image.asset(
                              department.imagePath!,
                              //height: MediaQuery.of(context).size.height * 0.2,
                              fit: BoxFit.cover,
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),

              // Profiles Section
              ListView.builder(
                padding: EdgeInsets.all(16.0),
                itemCount: profiles.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final profile = profiles[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          //offset: Offset(0, 4),
                          //blurRadius: 10,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        if (profile.imagePath != null)
                          ClipOval(
                            child: Image.asset(
                              profile.imagePath!,
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                        const SizedBox(height: 16),
                        Text(
                          'About Developer\n${profile.name}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        if (profile.description != null) ...[
                          const SizedBox(height: 16),
                          Text(
                            profile.description!,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                        const SizedBox(height: 30),
                        Text(
                          '(${profile.name})',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 20, color: Colors.blueGrey),
                        ),
                        const SizedBox(height: 20),
                        if (profile.profileUrl != null)
                          ElevatedButton(
                            onPressed: () => setState(() {
                              _launched = _abouturl(profile.profileUrl!);
                            }),
                            child: const Text('See more about me'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
