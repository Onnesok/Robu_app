import 'package:robu/Drawer_menu/about_screen.dart';
import 'package:robu/Drawer_menu/feedback_screen.dart';
import 'package:robu/Drawer_menu/help_screen.dart';
import 'package:robu/Drawer_menu/home_screen.dart';
import 'package:robu/Drawer_menu/invite_friend_screen.dart';
import 'package:flutter/material.dart';
import 'package:robu/home/btm_appbar.dart';
import 'package:robu/home/home_contents.dart';
import '../custom_drawer/drawer_user_controller.dart';
import '../custom_drawer/home_drawer.dart';

class NavigationHomeScreen extends StatefulWidget {
  const NavigationHomeScreen({super.key});

  @override
  State<NavigationHomeScreen> createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget screenView = const CustomBottomAppBar();
  DrawerIndex drawerIndex = DrawerIndex.home;

  @override
  Widget build(BuildContext context) {
    return DrawerUserController(
      screenIndex: drawerIndex,
      drawerWidth: MediaQuery.of(context).size.width * 0.75,
      onDrawerCall: (DrawerIndex drawerIndexdata) {
        changeIndex(drawerIndexdata);
        //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
      },
      screenView: screenView,
      //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      setState(() {
        drawerIndex = drawerIndexdata;

        switch (drawerIndex) {
          case DrawerIndex.home:
            screenView = const CustomBottomAppBar();
            break;
          case DrawerIndex.help:
            screenView = const HelpScreen();
            break;
          case DrawerIndex.feedback:
            screenView = const FeedbackScreen();
            break;
          case DrawerIndex.invite:
            screenView = const InviteFriend();
            break;
          case DrawerIndex.about:
            screenView = const AboutScreen();
            break;
        }
      });
    }
  }

}
