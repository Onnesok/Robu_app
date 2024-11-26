import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:robu/api/api_root.dart';
import 'package:robu/themes/app_theme.dart';
import 'package:robu/login/login.dart';
import 'package:robu/user_data/profile_provider.dart';

class registration extends StatefulWidget {
  const registration({super.key});

  @override
  State<registration> createState() => _registrationState();
}

class _registrationState extends State<registration> {
  final _formKey = GlobalKey<FormState>();
  bool passEnable = true;
  bool cpassEnable = true;

  final TextEditingController _NameController = TextEditingController();
  final TextEditingController _OrgController = TextEditingController(text: 'BRAC University');
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();



  Future<void> _registerUser() async {
    final String uri = "${api_root}/auth/users/";
    final Map<String, String> data = {
      'email': _emailController.text.trim(),
      'password': _passwordController.text.trim(),
      'name': _NameController.text.trim(),
      'org': _OrgController.text.trim(),
    };

    if (_formKey.currentState!.validate()) {
      try {
        var response = await http.post(
          Uri.parse(uri),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(data),
        );

        var jsonResponse = jsonDecode(response.body);
        // Check if the response status is OK (201)
        if (response.statusCode == 201) {
            Fluttertoast.showToast(msg: "Registration successful");
            Fluttertoast.showToast(msg: "Please login");

            // Navigate to the login screen
            _navigateToRoot(const login());
        } else {
          if (jsonResponse.containsKey('email')) {
            String emailError = jsonResponse['email'][0];
            Fluttertoast.showToast(msg: emailError);
            } else {
            Fluttertoast.showToast(msg: "Server error. Please try again later. ${response.body}");
          }
        }
      } catch (e) {
        // Handle network errors or other unexpected issues
        Fluttertoast.showToast(msg: "An error occurred. Please try again.");
        print("Error during registration: $e");
      }
    }
  }


  void _navigateToRoot(Widget page) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page),
          (Route<dynamic> route) => false,
    );
  }



  void _togglePasswordVisibility() {
    setState(() {
      passEnable = !passEnable;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      cpassEnable = !cpassEnable;
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: AppTheme.white,
      resizeToAvoidBottomInset: true,
      appBar: profileProvider.isLoggedIn ? AppBar(
        scrolledUnderElevation: 0.0,
        title: Text("Registration", style: TextStyle(color: Colors.black87)),
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
        height: MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/ui/background5.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/app_icon/icon.png',
                    height: 100,
                    width: 100,
                  ),
                  const Text(
                    "ROBU!",
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: AppTheme.grey),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    "Please Create Your Account",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.grey),
                  ),
                  const SizedBox(height: 6),
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 40, right: 40, bottom: 0, top: 10),
                        child: TextFormField(
                          controller: _NameController,
                          decoration: InputDecoration(
                            hintText: 'Full Name',
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: _NameController.text.isNotEmpty ? Colors.red : Colors.blueAccent,
                              ),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueAccent),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Full Name';
                            } else if (RegExp(r'\d').hasMatch(value)) {
                              return "Please enter a valid name";
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 40, right: 40, bottom: 0, top: 0),
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
                        margin: const EdgeInsets.only(left: 40, right: 40, bottom: 0, top: 10),
                        child: TextFormField(
                          controller: _OrgController,
                          decoration: InputDecoration(
                            hintText: 'University',
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: _NameController.text.isNotEmpty ? Colors.red : Colors.blueAccent,
                              ),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueAccent),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your University';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 40, right: 40, bottom: 0, top: 0),
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: passEnable,
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: passEnable ? Colors.blueAccent : Colors.red,
                              ),
                            ),
                            labelStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
                            hintText: "Password",
                            suffixIcon: IconButton(
                              onPressed: _togglePasswordVisibility,
                              icon: Icon(passEnable ? Icons.visibility_off : Icons.remove_red_eye),
                              color: Colors.black38,
                            ),
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
                        margin: const EdgeInsets.only(left: 40, right: 40, bottom: 20, top: 0),
                        child: TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: cpassEnable,
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: cpassEnable ? Colors.blueAccent : Colors.red,
                              ),
                            ),
                            labelStyle: TextStyle(color: Colors.black.withOpacity(0.6)),
                            hintText: "Confirm Password",
                            suffixIcon: IconButton(
                              onPressed: _toggleConfirmPasswordVisibility,
                              icon: Icon(cpassEnable ? Icons.visibility_off : Icons.remove_red_eye),
                              color: Colors.black38,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your Password';
                            } else if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                      ),
                      Center(
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
                              _registerUser();
                            },
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(fontSize: 18, letterSpacing: .4, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account?",
                              style: TextStyle(
                                letterSpacing: .6,
                                wordSpacing: 2,
                                fontSize: 14,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => const login()),
                                );
                              },
                              child: Text(
                                'Login',
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
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
