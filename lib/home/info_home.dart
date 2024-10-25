import 'package:flutter/material.dart';
import 'lists.dart';
import 'package:url_launcher/url_launcher.dart';

class Info_home extends StatefulWidget {
  const Info_home({required this.callBack, Key? key,}) : super(key: key);

  final Function() callBack;

  @override
  State<Info_home> createState() => _Info_homeState();
}

class _Info_homeState extends State<Info_home>
    with TickerProviderStateMixin {
  late final AnimationController animationController;
  Future<void>? _launched;

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

  void _onCategoryPressed(Category category) {
    final Uri robu_web = Uri(scheme: 'https', host: 'www.bracurobu.org');
    if (category.title == 'Basic of robotics') {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => bor()),
      // );
      //_launched = _Bor(toLaunch);
    } else if (category.title == 'Events') {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => eventpage()),
      // );
    }else if (category.title == 'Blood bank') {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => blood_bank()),
      // );
    } else if (category.title == 'panel') {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => robu_panel()),
      // );
    }
    else if (category.title == 'Regestration') {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => Registration()),
      // );
    } else if (category.title == 'Announcements') {
      /* Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AppDesignPage()),
      );*/
      _launched = _Bor(robu_web);
    }else if (category.title == 'Alumni') {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => Alumni()),
      // );
    } else if (category.title == "About Robu") {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => AboutScreen()),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return GridView(
              padding: const EdgeInsets.all(8),
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 12.0,
                crossAxisSpacing: 12.0,
                childAspectRatio: 0.6,
              ),
              children: List<Widget>.generate(
                Category.popularCourseList.length,
                    (int index) {
                  final int count = Category.popularCourseList.length;
                  final Animation<double> animation =
                  Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animationController,
                      curve: Interval((1 / count) * index, 1.0,
                          curve: Curves.fastOutSlowIn),
                    ),
                  );
                  animationController.forward();
                  return CategoryView(
                    callback: () {
                      widget.callBack();
                    },
                    category: Category.popularCourseList[index],
                    animation: animation,
                    animationController: animationController,
                    onPressed: () =>
                        _onCategoryPressed(Category.popularCourseList[index]),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}

// category_view.dart

class CategoryView extends StatelessWidget {
  const CategoryView({
    required this.category,
    required this.animationController,
    required this.animation,
    required this.callback,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final VoidCallback callback;
  final VoidCallback onPressed;
  final Category category;
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
                0.0, 50 * (1.0 - animation.value), 0.0
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                onTap: () {
                  onPressed();
                  callback();
                },
                child: Stack(
                  //alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Expanded(
                          child: Ink(
                            decoration: const BoxDecoration(
                              //color: Color(0xFFF8FAFB),
                              color: Colors.white70,
                              borderRadius: BorderRadius.all(Radius.circular(16.0)),
                            ),
                            /////////////////////// from here ////////////////////////////
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Container(
                                /*decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0),
                                  ),
                                  *//*boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: DesignCourseAppTheme.grey.withOpacity(0.2), blurRadius: 6.0
                                    ),
                                  ],*//*
                                ),*/
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.withOpacity(0.2)),
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                      const BorderRadius.all(Radius.circular(16.0)),
                                      child: AspectRatio(
                                        aspectRatio: 1,
                                        child: Image.asset(category.imagePath),
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Text(category.title,
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
                            /*Column(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 16, left: 16, right: 16),
                                        child: Text(
                                          category.title,
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            letterSpacing: 0.27,
                                            color: DesignCourseAppTheme
                                                .darkerText,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),*/
                          ),
                        ),
                      ],
                    ),

                    ///////////////////////////////////////////////////////////////////////////////

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