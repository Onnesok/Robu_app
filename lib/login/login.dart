import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:robu/custom_drawer/navigation_home_screen.dart';
import 'package:robu/login/registration.dart';
import 'package:robu/themes/app_theme.dart';
import 'package:robu/user_data/profile_provider.dart';

import '../api/api_root.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final _formKey = GlobalKey<FormState>();
  bool passEnable = true;
  bool isPasswordcorrect = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> login(String email, String password) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      var reqBody = {
        "email": email,
        "password": password,
      };

      try {
        var response = await http.post(
          Uri.parse("${api_root}/auth/jwt/create/"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(reqBody),
        );

        print('Raw response body: ${response.body}');

        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);

          // Check for access and refresh tokens
          if (jsonResponse.containsKey('access') && jsonResponse.containsKey('refresh')) {
            final accessToken = jsonResponse['access'];
            final refreshToken = jsonResponse['refresh'];

            // Store the tokens using ProfileProvider
            final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
            await profileProvider.storeAccessToken(accessToken);
            await profileProvider.storeRefreshToken(refreshToken);
            // Fetch user profile
            await _fetchUserProfile(accessToken);
            Fluttertoast.showToast(msg: "Login successful");

          } else {
            Fluttertoast.showToast(msg: "Login failed");
          }
        } else {
          // Handle specific error codes with better user feedback
          final errorMsg = jsonDecode(response.body)['detail'] ?? "Failed to login.";
          Fluttertoast.showToast(msg: "Login Failed..... Please try again");
          print("Login failed: $errorMsg");
        }
      } catch (e) {
        Fluttertoast.showToast(msg: "An unexpected error occurred.");
        print('Exception: $e');
      }
    } else {
      Fluttertoast.showToast(msg: "Email and password must not be empty.");
    }
  }


  // Fetch the user profile after successful login
  Future<void> _fetchUserProfile(String accessToken) async {
    const String apiEndpoint = '${api_root}/update-profile/';

    try {
      final response = await http.get(
        Uri.parse(apiEndpoint),
        headers: {'Authorization': 'JWT $accessToken'},
      );

      if (response.statusCode == 200) {
        final userProfile = jsonDecode(response.body);
        print(response.body);

        // Safely fetch and handle null values for all fields
        final fullName = userProfile['name'] ?? 'Unknown User';
        final userEmail = userProfile['email'] ?? 'Email not provided';
        final studentId = userProfile['student_id'] ?? '';
        final position = userProfile['position'] ?? 'No position assigned';
        final department = userProfile['department'] ?? '';
        final avatarUrl = userProfile['avatar'] ?? '';
        final bloodGroup = userProfile['blood_group'] ?? '';
        final gender = userProfile['gender'] ?? '';
        final org = userProfile['org'] ?? '';
        final instaLink = userProfile['insta_link'] ?? '';
        final facebookProfile = userProfile['facebook_profile'] ?? '';
        final linkedinLink = userProfile['linkedin_link'] ?? '';
        final bracuStart = userProfile['bracu_start'] ?? '';
        final dateOfBirth = userProfile['date_of_birth'] ?? '';
        final isVerified = userProfile['is_verified'] ?? false;
        final isAdmin = userProfile['is_admin'] ?? false;
        final phoneNumber = userProfile['phone_number'] ?? '';
        final rsStatus = userProfile['rs_status'] ?? '';
        final address = userProfile['address'] ?? '';
        final robuDepartment = userProfile['robu_department'] ?? '';

        // Update user details in ProfileProvider
        final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
        await profileProvider.saveProfileData({
          'name': fullName,
          'email': userEmail,
          'student_id': studentId,
          'position': position,
          'department': department,
          'avatar': avatarUrl,
          'blood_group': bloodGroup,
          'gender': gender,
          'org': org,
          'insta_link': instaLink,
          'facebook_profile': facebookProfile,
          'linkedin_link': linkedinLink,
          'bracu_start': bracuStart,
          'date_of_birth': dateOfBirth,
          'is_verified': isVerified,
          'is_admin': isAdmin,
          'phone_number': phoneNumber,
          'rs_status': rsStatus,
          'address': address,
          'robu_department': robuDepartment,
        });
        print("Profile fetched");

        await profileProvider.updateLoginStatus(true);    // Saved that user is logged in right now ...  yo :D
        _navigateTo(NavigationHomeScreen());
      } else {
        // Handle unauthorized or other errors
        print("Error fetching profile: ${response.statusCode}");
      }
    } catch (e) {
      print("An error occurred while fetching profile: $e");
    }
  }



  void _navigateTo(Widget page) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page));
  }

  // Decode the JWT token (no verification, just decoding the payload)
  void decodeToken(String token) {
    try {
      final jwt = JwtDecoder.decode(token);
      print('Decoded Payload: ${jwt}');
    } catch (e) {
      print('Error decoding token: $e');
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      passEnable = !passEnable;
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: profileProvider.isLoggedIn ? AppBar(
        scrolledUnderElevation: 0.0,
        title: Text("Login", style: TextStyle(color: Colors.black87)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      )
          : null,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/ui/background2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/app_icon/icon.png',
                    height: 100,
                    width: 100,
                  ),
            
                  const Text(
                    "Welcome Back!",
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              left: 40, right: 40, bottom: 0, top: 0),
                          child: TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              hintText: "Email",
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blueAccent),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your email";
                              } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                  .hasMatch(value)) {
                                return "Please enter a valid email";
                              } else if (value.contains("@g.bracu.ac.bd")) {
                                return "Please use gmail instead of g-suite";
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 40, right: 40, bottom: 0, top: 0),
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: passEnable,
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: isPasswordcorrect
                                      ? Colors.blueAccent
                                      : Colors.red,
                                ),
                              ),
                              hintText: "Password",
                              suffixIcon: IconButton(
                                onPressed: _togglePasswordVisibility,
                                icon: Icon(passEnable
                                    ? Icons.visibility_off
                                    : Icons.remove_red_eye),
                                color: Colors.black38,
                              ),
                              errorMaxLines: 2,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your password";
                              } else if (value.length < 8) {
                                return "Password must be at least 8 characters long";
                              } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
                                return "Password must include at least one uppercase letter";
                              } else if (!RegExp(r'[a-z]').hasMatch(value)) {
                                return "Password must include at least one lowercase letter";
                              } else if (!RegExp(r'\d').hasMatch(value)) {
                                return "Password must include at least one number";
                              } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                                return "Password must include at least one special character";
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 30),
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Fluttertoast.showToast(
                                  msg: 'Not Applicable right now',
                                  gravity: ToastGravity.TOP);
                            },
                            child: const Text(
                              'Forgot password',
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: const EdgeInsets.only(top: 20, right: 20, left: 20),
                            child: SizedBox(
                              height: 60,
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.blueaccent,
                                  elevation: 6,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  padding: const EdgeInsets.all(18),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    login(
                                      _emailController.text,
                                      _passwordController.text,
                                    );
                                  }
                                },
                                child: const Text(
                                  "Sign In",
                                  style: TextStyle(
                                    fontSize: 18,
                                    letterSpacing: .4,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  letterSpacing: .6,
                                  wordSpacing: 2,
                                  fontSize: 14,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  _navigateTo(registration());
                                },
                                child: Text(
                                  'Sign up',
                                  style: TextStyle(
                                    color: Colors.blue[800],
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        color: Colors.blueAccent[200]!.withOpacity(0.6), // Outer glow
                                        blurRadius: 20,
                                      ),
                                      Shadow(
                                        color: Colors.blue[200]!.withOpacity(0.4), // Inner glow
                                        blurRadius: 40,
                                      ),
                                      Shadow(
                                        color: Colors.blue.withOpacity(0.2), // Subtle glow
                                        blurRadius: 60,
                                      ),
                                    ],
                                  ),
                                )
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
}