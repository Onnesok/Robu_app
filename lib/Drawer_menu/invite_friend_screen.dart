import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../themes/app_theme.dart';

class InviteFriend extends StatefulWidget {
  const InviteFriend({super.key});

  @override
  State<InviteFriend> createState() => _InviteFriendState();
}

class _InviteFriendState extends State<InviteFriend> {
  void _shareContent() {
    print("share button tapped");
    Share.share(
      'Check out this amazing platform! Get onboard and start exploring: https://www.facebook.com/BRACU.Robotics.Club',
      subject: 'Invite to Join the Platform',
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: AppTheme.white,
      appBar: AppBar(
        title: const Text("Invite"),
        centerTitle: true,
        backgroundColor: AppTheme.white,
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Image.asset(
              'assets/ui/inviteImage.png',
              height: MediaQuery.of(context).size.height * 0.3,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 20),
            child: const Text(
              'Invite Your Friends',
              style: AppTheme.headline,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: const Text(
              'Invite your friends to join this platform and help them get started on their journey!',
              textAlign: TextAlign.center,
              style: AppTheme.body1,
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: bottomPadding + 30),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: ElevatedButton(
                onPressed: _shareContent,
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
                      Icons.share,
                      color: Colors.white,
                      size: 24,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Share with Friends',
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
    );
  }
}
