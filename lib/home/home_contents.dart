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
      body: Material(
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
      ),
    );
  }

  Widget appBar() {
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
                                // Adds balanced padding around the icon
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
                                  children: [
                                    Text(
                                      "anonymous",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text("Status: User"),
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
                            child: Icon(Icons.notifications_none_outlined),
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


  ///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////


  Widget getCategoryUI(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CategoryListView(
          callBack: () {
            /* Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CourseInfoScreen(categoryType: categoryType)),
              ); */
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            children: <Widget>[
              getButtonUI(context, CategoryType.Controller,
                  isSelected: categoryType == CategoryType.Controller),
              const SizedBox(width: 16),
              getButtonUI(context, CategoryType.robotics,
                  isSelected: categoryType == CategoryType.robotics),
              const SizedBox(width: 16),
              getButtonUI(context, CategoryType.coding,
                  isSelected: categoryType == CategoryType.coding),
            ],
          ),
        ),
      ],
    );
  }

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
          border: Border.all(color: Colors.redAccent.shade200),
        ),
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
                    color: isSelected ? Colors.black87 : Colors.black87,
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
///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////

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
        SizedBox(height: 50,),
      ],
    ),
  );
}

enum CategoryType {
  Controller,
  robotics,
  coding,
}
