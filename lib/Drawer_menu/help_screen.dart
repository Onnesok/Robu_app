import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../themes/app_theme.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        title: const Text("Help Center"),
        centerTitle: true,
        backgroundColor: AppTheme.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/ui/helpimage.png',
                height: 250,
              ),
              const SizedBox(height: 8),
              const Text(
                'How can we help you?',
                style: AppTheme.headline,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: const Text(
                  'If you are facing any problem, feel free to get in touch with us. ROBU is available for your support... This is the support or help page for the app... Feel free to contact us...',
                  textAlign: TextAlign.justify,
                  style: AppTheme.body1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: ElevatedButton(
                    onPressed: () {
                      Fluttertoast.showToast(msg: "Coming soon");
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: AppTheme.blueaccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 10,
                      shadowColor: AppTheme.blueaccent.withOpacity(0.5),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const <Widget>[
                        Icon(
                          Icons.message_outlined,
                          color: Colors.white,
                          size: 24,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Chat with us',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis,
                          ),
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
}
