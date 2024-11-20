import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:robu/custom_drawer/navigation_home_screen.dart';
import 'package:robu/login/login.dart';
import 'package:robu/user_data/profile_provider.dart';
import 'themes/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Ensure the app only runs in portrait mode
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // Load SharedPreferences before running the app
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    // Set up system UI
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ],
      child: Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
          // Check if the user is logged in
          return MaterialApp(
            title: 'Robu',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: AppTheme.textTheme,
              platform: TargetPlatform.iOS,
            ),
            home: profileProvider.isLoggedIn
                ? const Scaffold(
              body: SafeArea(
                top: false,
                bottom: false,
                child: NavigationHomeScreen(),
              ),
            )
                : const Scaffold(
              body: SafeArea(
                top: false,
                bottom: false,
                child: login(),
              ),
            ),
          );
        },
      ),
    );
  }
}
