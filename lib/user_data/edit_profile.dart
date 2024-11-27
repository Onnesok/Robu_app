import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:robu/themes/app_theme.dart';
import 'package:robu/user_data/profile_provider.dart';
import 'package:robu/user_data/recruitment.dart';
import 'package:robu/user_data/utils/custom_input_field.dart';
import 'package:robu/user_data/utils/custom_dropdown_field.dart';

import '../api/api_root.dart';
import '../login/login.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController organizationController = TextEditingController();
  final TextEditingController studentIdController = TextEditingController();
  final TextEditingController gsuitEmailController = TextEditingController();
  final TextEditingController bloodGroupController = TextEditingController();
  final TextEditingController facebookController = TextEditingController();
  final TextEditingController githubController = TextEditingController();
  final TextEditingController linkedInController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Dropdown values
  List<String> rsStatusOptions = [
    "Not yet attended",
    "60",
    "61",
    "62",
    "63",
    "64",
    "65",
    "66",
    "67"
  ];
  List<String> genderOptions = ["select", "male", "female", "other"];
  String? rsStatus;
  String? gender;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchAndLoadProfile();
  }

  Future<void> _refreshToken() async {
    const String url = "${api_root}/auth/jwt/refresh/";
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    final refreshToken = profileProvider.refreshToken;
    Fluttertoast.showToast(msg: refreshToken);

    // Ensure refresh token is available and not empty
    if (refreshToken != null && refreshToken.isNotEmpty && refreshToken != "") {
      try {
        var response = await http.post(
          Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "refresh": refreshToken,
          }),
        );

        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body);

          // Retrieve and store the new access token
          String? newAccessToken = jsonResponse["access"];
          if (newAccessToken != null) {
            await profileProvider.storeAccessToken(newAccessToken);
            print("Access token refreshed successfully.");
          } else {
            print(
                "Failed to retrieve new access token. Response: ${response.body}");
            Fluttertoast.showToast(
                msg: "Please login again... session expired");
          }
        } else if (response.statusCode == 401) {
          print("Refresh token expired or invalid. Response: ${response.body}");
          Fluttertoast.showToast(msg: "Session expired. Please log in again.");
        } else {
          // Log other response codes
          print("Failed to refresh token. Status code: ${response.statusCode}");
          print("Response: ${response.body}");
        }
      } catch (e) {
        print("Error occurred while refreshing token: $e");
      }
    } else {
      // If refresh token is null or empty
      print("No valid refresh token found. Redirecting to login.");
      Fluttertoast.showToast(msg: "Please log in to continue.");
    }
  }

  Future<void> _fetchAndLoadProfile() async {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    final accessToken = profileProvider.accessToken;

    if (accessToken != null) {
      try {
        await _fetchUserProfile(accessToken);
        _initializeControllers(
            profileProvider); // Initialize controllers after fetching
        setState(() {
          _isLoading = false;
        });
      } catch (error) {
        print("Error fetching profile: $error");
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      print("No access token found. User is not authenticated.");
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchUserProfile(String accessToken) async {
    const String apiEndpoint = '${api_root}/update-profile/';
    final response = await http.get(
      Uri.parse(apiEndpoint),
      headers: {'Authorization': 'JWT $accessToken'},
    );

    if (response.statusCode == 200) {
      final userProfile = jsonDecode(response.body);
      final profileProvider =
          Provider.of<ProfileProvider>(context, listen: false);
      await profileProvider
          .saveProfileData(userProfile); // Saving profile data to provider
    } else {
      await _refreshToken();
      Fluttertoast.showToast(msg: "Failed to fetch profile....");
      Fluttertoast.showToast(msg: "Please login again....");
      throw Exception('Failed to fetch profile');
    }
  }

  void _initializeControllers(ProfileProvider profileProvider) {
    nameController.text = profileProvider.fullName ?? '';
    addressController.text = profileProvider.address ?? '';
    dobController.text = profileProvider.dateOfBirth ?? '';
    phoneController.text = profileProvider.phoneNumber ?? '';
    organizationController.text = profileProvider.org ?? '';
    studentIdController.text = profileProvider.studentId ?? '';
    gsuitEmailController.text = profileProvider.secondaryEmail ?? '';
    bloodGroupController.text = profileProvider.bloodGroup ?? '';
    facebookController.text = profileProvider.facebookProfile ?? '';
    githubController.text = profileProvider.instaLink ?? '';
    linkedInController.text = profileProvider.linkedinLink ?? '';

    rsStatus = rsStatusOptions.contains(profileProvider.rsStatus)
        ? profileProvider.rsStatus
        : rsStatusOptions.first;

    gender = genderOptions.contains(profileProvider.gender)
        ? profileProvider.gender
        : genderOptions.first;
  }

  void _updateProfile(bool go_to_page) async {
    final url = Uri.parse('${api_root}/update-profile/');
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    final _accessToken = profileProvider.accessToken;

    // Create a map of the data to be sent
    final Map<String, dynamic> data = {
      'name': nameController.text.trim(),
      'address': addressController.text.trim(),
      'email:': profileProvider.email,
      'date_of_birth': dobController.text.trim(),
      'phone_number': phoneController.text.trim(),
      'org': organizationController.text.trim(),
      'student_id': studentIdController.text.trim(),
      'secondary_email': gsuitEmailController.text.trim(),
      'blood_group': bloodGroupController.text.trim(),
      'facebook_profile': facebookController.text.trim(),
      'insta_link': githubController.text.trim(),
      'linkedin_link': linkedInController.text.trim(),
      'rs_status': rsStatus,
      'gender': gender,
    };

    try {
      final response = await http.patch(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'JWT $_accessToken',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Profile updated successfully!");
        if(go_to_page == true) {
          _navigateTo(Recruitment());
        } else {
          Navigator.pop(context); 
        }
      } else {
        final errorResponse = jsonDecode(response.body);
        Fluttertoast.showToast(msg: "Failed to update... Please try again...");
      }
    } catch (error) {
      Fluttertoast.showToast(msg: "Error: $error");
    }
  }

  void _navigateTo(Widget page) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page));
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        title:
            const Text("Edit Profile", style: TextStyle(color: Colors.black87)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              CustomInputField(
                controller: nameController,
                label: "Name",
                hintText: "Enter your name",
                helperText: "Provide your full name.",
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter your full Name";
                  } else if (RegExp(r'\d').hasMatch(value)) {
                    return "Please enter a valid name";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CustomInputField(
                controller: addressController,
                label: "Address",
                hintText: "Enter your address",
                helperText:
                    "Provide your complete address, including street and city.",
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter your address";
                  } else if (value.trim().length < 3) {
                    return "Address must be at least 3 characters long";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CustomInputField(
                controller: dobController,
                label: "Date of Birth",
                hintText: "yyyy-mm-dd",
                helperText: "Please select your date of birth.",
                keyboardType: TextInputType.number,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_month_rounded),
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.light(
                              primary: Colors.blueAccent,
                              onPrimary: Colors.white,
                              onSurface: Colors.black,
                              background: Colors.lightBlue.shade50,
                            ),
                            dialogBackgroundColor: Colors.lightBlue.shade100,
                            buttonTheme: ButtonThemeData(
                              textTheme: ButtonTextTheme.primary,
                              buttonColor: Colors.blueAccent,
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (pickedDate != null) {
                      setState(() {
                        // Format the date as yyyy-mm-dd
                        dobController.text =
                        "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                      });
                    }
                  },
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Date of Birth is required.';
                  }
                  // Check if the input matches the format yyyy-mm-dd
                  final regex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
                  if (!regex.hasMatch(value)) {
                    return 'Invalid date format. Use yyyy-mm-dd.';
                  }
                  // Parse the date to ensure it's valid
                  try {
                    DateTime dob = DateTime.parse(value);
                    DateTime today = DateTime.now();
                    // Check if the age is realistic...
                    int age = today.year - dob.year;
                    if (today.month < dob.month ||
                        (today.month == dob.month && today.day < dob.day)) {
                      age--;
                    }
                    if (age < 18 || age > 130 || dob.isAfter(today)) {
                      return 'Please enter a valid age.';
                    }
                  } catch (e) {
                    return 'Invalid date. Please select a valid date.';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 20),
              CustomInputField(
                controller: phoneController,
                label: "Phone",
                hintText: "Enter your phone number",
                helperText: "Provide your contact phone number.",
                keyboardType: TextInputType.number,
                validator: (value) {
                  final regExp = RegExp(r'^(?:\+8801|01)[3-9]\d{8}$');
                  if (value == null || value.isEmpty) {
                    return 'Phone number is required';
                  } else if (value.length < 11) {
                    return "Phone number should be 11 digit";
                  } else if (!regExp.hasMatch(value)) {
                    return 'Enter a valid phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CustomInputField(
                controller: organizationController,
                label: "Organization",
                hintText: "Enter your organization",
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter your University name";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CustomInputField(
                controller: studentIdController,
                label: "Student ID",
                hintText: "Enter your student ID",
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter your 8 digit Student ID";
                  } else if (value.length < 8) {
                    return "Please enter a valid Student ID";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              DropdownField(
                label: "RS Status",
                value: rsStatus,
                items: rsStatusOptions,
                onChanged: (newValue) {
                  setState(() {
                    rsStatus = newValue;
                  });
                },
              ),
              const SizedBox(height: 20),
              CustomInputField(
                controller: gsuitEmailController,
                label: "G Suite Email",
                hintText: "Enter your G Suite email",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  final emailPattern = r'^[a-zA-Z0-9._%+-]+@g\.bracu\.ac\.bd$';
                  final regex = RegExp(emailPattern);

                  if (!regex.hasMatch(value)) {
                    return 'Please enter a valid G Suite email';
                  }
                  return null; // Validation passed
                },
              ),
              const SizedBox(height: 20),
              CustomInputField(
                controller: bloodGroupController,
                label: "Blood Group",
                hintText: "Enter your blood group",
                helperText: "Optional: Provide your blood group if known.",
              ),
              const SizedBox(height: 20),
              DropdownField(
                label: "Gender",
                value: gender,
                items: genderOptions,
                onChanged: (newValue) {
                  setState(() {
                    gender = newValue;
                  });
                },
              ),
              const SizedBox(height: 20),
              CustomInputField(
                controller: facebookController,
                label: "Facebook Link",
                hintText: "Enter your Facebook link",
                helperText: "e.g., https://www.facebook.com/username",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Facebook ID is required';
                  }
                  final facebookPattern =
                      r'^(https?:\/\/)?(www\.)?facebook\.com\/[a-zA-Z0-9._-]+\/?$';
                  final regex = RegExp(facebookPattern);

                  if (!regex.hasMatch(value)) {
                    return 'Please enter a valid Facebook ID';
                  }
                  return null; // Validation passed
                },
              ),
              const SizedBox(height: 20),
              CustomInputField(
                controller: githubController,
                label: "Github Link (Optional)",
                hintText: "Enter your Github link",
              ),
              const SizedBox(height: 20),
              CustomInputField(
                controller: linkedInController,
                label: "LinkedIn (Optional)",
                hintText: "Enter your LinkedIn",
              ),
              const SizedBox(height: 40),
              Center(
                child: Container(
                  margin:
                      const EdgeInsets.only(right: 20, left: 20, bottom: 30),
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
                        if (_formKey.currentState?.validate() ?? false) {
                          (profileProvider.position == null || profileProvider.position == "Not a Member")
                              ? _updateProfile(true)
                              : _updateProfile(false);
                        } else {
                          Fluttertoast.showToast(
                              msg: "Please fill up the form correctly");
                        }
                      },
                      child: Text(
                        (profileProvider.position == null || profileProvider.position == "Not a Member")
                            ? "Next"
                            : "Update",
                        style: const TextStyle(
                          fontSize: 18,
                          letterSpacing: .4,
                          color: Colors.white,
                        ),
                      ),
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
