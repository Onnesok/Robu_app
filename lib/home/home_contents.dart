import 'package:flutter/material.dart';
import 'dart:ui';
import '../themes/app_theme.dart';
import 'category_list_view.dart';
import 'package:robu/home/info_home.dart';

class HomeContents extends StatefulWidget {
  const HomeContents({super.key});

  @override
  State<HomeContents> createState() => _HomeContentsState();
}

class _HomeContentsState extends State<HomeContents> {
  CategoryType categoryType = CategoryType.Controller;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppTheme.nearlyWhite,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/ui/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            appBar(),
            Expanded(
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: <Widget>[
                      getCategoryUI(context),
                      Flexible(
                        child: getInfoSectionUI(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

///////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////
  ////////////////////////////////////////////////

  Widget appBar() {
    return Center(
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            color: Colors.white
                .withOpacity(0.5), // Adjust opacity for desired effect
            child: SizedBox(
              height: AppBar().preferredSize.height,
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
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            'ROBU',
                            style: TextStyle(
                              fontSize: 22,
                              color: AppTheme.darkText,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(right: 20),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Ratul Hasan",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text("phone number"),
                                ],
                              ),
                              SizedBox(width: 5,),
                              ClipOval(
                                child: Image.asset("assets/dev/ratul.jpg",
                                  height: 35,
                                  width: 35,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 10,),
                              Transform.rotate(
                                angle: 0.1,
                                child: Icon(Icons.notifications_none_outlined),
                              ),
                            ],
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
      ),
    );
  }

  ////////////////////////////////////////////////////////
  //////////////////////////////////////////////////
  ////////////////////////////
  Widget getCategoryUI(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(top: 4.0, left: 18, right: 16),
          child: Text(
              ""),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            children: <Widget>[
              getButtonUI(context, CategoryType.Controller,
                  isSelected: categoryType == CategoryType.Controller),
              const SizedBox(
                width: 16,
              ),
              getButtonUI(context, CategoryType.robotics,
                  isSelected: categoryType == CategoryType.robotics),
              const SizedBox(
                width: 16,
              ),
              getButtonUI(context, CategoryType.coding,
                  isSelected: categoryType == CategoryType.coding),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        CategoryListView(
          callBack: () {
/*            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CourseInfoScreen(categoryType: categoryType)),
            );*/
          },
        ),
      ],
    );
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget getButtonUI(BuildContext context, CategoryType categoryTypeData,
      {bool isSelected = false}) {
    String txt = '';
    if (CategoryType.Controller == categoryTypeData) {
      txt = 'Controller';
    } else if (CategoryType.robotics == categoryTypeData) {
      txt = 'Robotics';
    } else if (CategoryType.coding == categoryTypeData) {
      txt = 'Coding';
    }
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: AppTheme.nearlyWhite,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            border: Border.all(color: Colors.redAccent.shade200)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.redAccent,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            onTap: () {
              if (mounted) {
                setState(() {
                  categoryType = categoryTypeData;
                });
                if (categoryTypeData == CategoryType.robotics) {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) =>
                  //           RoboticsPage()),
                  // );
                } else if (categoryTypeData == CategoryType.coding) {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => coding()),
                  // );
                } else if (categoryTypeData == CategoryType.Controller) {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => controller_page()),
                  // );
                }
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, left: 16, right: 16),
              child: Center(
                child: Text(
                  txt,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    letterSpacing: 0.27,
                    color: isSelected
                        ? Colors.black87 //DesignCourseAppTheme.nearlyWhite
                        : Colors.black87,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


Widget getInfoSectionUI() {
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
        Flexible(
          child: Info_home(
            callBack: () {},
          ),
        ),
      ],
    ),
  );
}

enum CategoryType {
  Controller,
  robotics,
  coding,
}