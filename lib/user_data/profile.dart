import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:robu/themes/app_theme.dart';
import 'package:robu/login/login.dart';
import 'package:robu/user_data/dashboard.dart';
import 'package:robu/user_data/recruitment.dart';
import 'profile_provider.dart';
import 'edit_profile.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/ui/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                "Profile",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ImagePicker _imagePicker = ImagePicker();

  void _signOut() async {
    try {
      final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
      await profileProvider.clear();

      Navigator.of(context, rootNavigator: true).pushReplacement(
        MaterialPageRoute(builder: (context) => const login()),
      );

      _showSnackBar('Logged out successfully');
    } catch (e) {
      _showToast('Error signing out: $e');
    }
  }

  Future<void> _selectImage() async {
    final pickedFile =
    await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      Provider.of<ProfileProvider>(context, listen: false)
          .updateImage(File(pickedFile.path));
      _showToast('Profile picture updated');
    }
  }

  void _navigateTo(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  void _showToast(String message) {
    Fluttertoast.showToast(msg: message, gravity: ToastGravity.TOP);
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Image.asset(
              'assets/app_icon/icon.png',
              fit: BoxFit.contain,
              height: 30,
            ),
            const SizedBox(width: 10),
            Text(
              message,
              style: const TextStyle(color: Colors.black87, fontSize: 16),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return Container(
      height: MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/ui/background4.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Profile Picture Section
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  GestureDetector(
                    onTap: _selectImage,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: AppTheme.white,
                      backgroundImage: profileProvider.pickedImage != null
                          ? FileImage(profileProvider.pickedImage!)
                      as ImageProvider<Object>?
                          : const AssetImage('assets/app_icon/icon.png'),
                    ),
                  ),
                  GestureDetector(
                    onTap: _selectImage,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.blue[800],
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Name
              Text(
                profileProvider.fullName,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),

              // Divider
              Container(
                height: 1,
                color: Colors.black38,
              ),
              const SizedBox(height: 20),

              // List Tiles
              _buildOptionCard(Icons.person_outline_rounded, 'Edit Profile', () => _navigateTo(EditProfile())),
              _buildOptionCard(Icons.dashboard_customize_outlined, 'Dashboard', () => _navigateTo(Dashboard())),
              _buildOptionCard(Icons.person_add_alt_outlined, 'SPRING 2025 Recruitment', () => _navigateTo(Recruitment())),
              //_buildOptionCard(Icons.settings, 'Settings', () => {}),
              _buildOptionCard(Icons.logout, 'Logout', _signOut, textColor: Colors.red),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard(IconData icon, String text, VoidCallback onTap,
      {Color? textColor}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue[700], size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: textColor ?? Colors.black87,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18),
          ],
        ),
      ),
    );
  }


}
