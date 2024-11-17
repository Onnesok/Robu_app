import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../themes/app_theme.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  late TextEditingController _feedbackController;

  @override
  void initState() {
    super.initState();
    _feedbackController = TextEditingController();
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        title: const Text("Feedback"),
        centerTitle: true,
        backgroundColor: AppTheme.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/ui/feedbackImage.png',
                height: 250,
              ),
              const SizedBox(height: 8),
              const Text(
                'Your Feedback',
                style: AppTheme.headline,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Text(
                  'Give your best time for this moment.',
                  textAlign: TextAlign.center,
                  style: AppTheme.body1,
                ),
              ),
              _buildComposer(),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: ElevatedButton(
                    onPressed: () async{
                      print(_feedbackController.text);
                      Fluttertoast.showToast(msg: "Feedback coming soon");
                      _feedbackController.clear();
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
                          Icons.bubble_chart_outlined,
                          color: AppTheme.white,
                          size: 24,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Send Feedback',
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

  Widget _buildComposer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: AppTheme.grey.withOpacity(0.6),
              offset: const Offset(4, 4),
              blurRadius: 8,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            padding: const EdgeInsets.all(16.0),  // Increase padding here
            color: AppTheme.white,
            child: TextField(
              controller: _feedbackController,
              maxLines: null,
              textInputAction: TextInputAction.done,
              style: const TextStyle(
                fontFamily: AppTheme.fontName,
                fontSize: 16,
                color: AppTheme.darkGrey,
              ),
              cursorColor: Colors.blue,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter your feedback...',
                contentPadding: EdgeInsets.symmetric(vertical: 10),  // Vertical padding for text field content
              ),
            ),
          ),
        ),
      ),
    );
  }

}
