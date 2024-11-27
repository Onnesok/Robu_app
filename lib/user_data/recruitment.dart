import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:robu/user_data/profile_provider.dart';
import 'package:robu/user_data/utils/custom_dropdown_field.dart';
import 'package:robu/user_data/utils/custom_input_field.dart';
import 'package:http/http.dart' as http;
import '../api/api_root.dart';
import '../themes/app_theme.dart';

class Recruitment extends StatefulWidget {
  const Recruitment({super.key});

  @override
  State<Recruitment> createState() => _RecruitmentState();
}

class _RecruitmentState extends State<Recruitment> {
  final TextEditingController AboutController = TextEditingController();
  String? PrimaryDepartment;
  String? SecondaryDepartment;
  final _formKey = GlobalKey<FormState>();

  List<String> PrimaryDepartmentOptions = [
    "Editorial and Publications",
    "IT",
    "Arts and Design",
    "Human Resources",
    "Event Management",
    "Finance and Marketing",
    "Research and Project Management",
    "Strategic Planning"
  ];

  List<String> SecondaryDepartmentOptions = [
    "Editorial and Publications",
    "IT",
    "Arts and Design",
    "Human Resources",
    "Event Management",
    "Finance and Marketing",
    "Research and Project Management",
    "Strategic Planning"
  ];


  void _ApplyToRobu() async {
    //final url = Uri.parse('${api_root}/update-profile/');
    final url = Uri.parse("Nothing");
    final profileProvider =
    Provider.of<ProfileProvider>(context, listen: false);
    final _accessToken = profileProvider.accessToken;

    // Create a map of the data to be sent
    final Map<String, dynamic> data = {
      // 'name': nameController.text.trim(),
      // 'address': addressController.text.trim(),
      // 'email:': profileProvider.email,
      // 'date_of_birth': dobController.text.trim(),
      // 'phone_number': phoneController.text.trim(),
      // 'org': organizationController.text.trim(),
      // 'student_id': studentIdController.text.trim(),
      // 'secondary_email': gsuitEmailController.text.trim(),
      // 'blood_group': bloodGroupController.text.trim(),
      // 'facebook_profile': facebookController.text.trim(),
      // 'insta_link': githubController.text.trim(),
      // 'linkedin_link': linkedInController.text.trim(),
      // 'rs_status': rsStatus,
      // 'gender': gender,
      'primaryDepartment': PrimaryDepartment,
      'SecondaryDepartment': SecondaryDepartment,
      'about': AboutController.text.trim()
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
          Navigator.pop(context);
      } else {
        final errorResponse = jsonDecode(response.body);
        Fluttertoast.showToast(msg: "Failed to update... Please try again...");
      }
    } catch (error) {
      Fluttertoast.showToast(msg: "Error: $error");
    }
  }


  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        title: Text("Recruitment", style: TextStyle(color: Colors.black87)),
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownField(
                  label: "First Choice Department",
                  value: PrimaryDepartment,
                  items: PrimaryDepartmentOptions,
                  onChanged: (newValue) {
                    setState(() {
                      PrimaryDepartment = newValue;
                    });
                  },
                ),

                SizedBox(height: 16,),

                DropdownField(
                  label: "Second Choice Department",
                  value: SecondaryDepartment,
                  items: SecondaryDepartmentOptions,
                  onChanged: (newValue) {
                    setState(() {
                      SecondaryDepartment = newValue;
                    });
                  },
                ),

                SizedBox(height: 16,),

                Text(" About", style: AppTheme.body_grey.copyWith(color: AppTheme.nearlyBlack, fontSize: 16),),

                SizedBox(height: 16,),

                CustomInputField(
                  controller: AboutController,
                  label: "About",
                  hintText: "Tell us a bit about yourself...",
                  helperText: "Share your hobbies, skills, or areas of expertise in 200-250 words.....",
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter something about yourself.";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Share your hobbies, skills, or areas of expertise.....",
                    hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  maxLines: 5,
                ),


                SizedBox(height: 66,),



                Center(
                  child: Container(
                    margin:
                    const EdgeInsets.only(right: 20, left: 20, bottom: 30),
                    child: SizedBox(
                      height: 60,
                      width: MediaQuery.of(context).size.width * 0.7,
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
                          if ((_formKey.currentState?.validate() ?? false) && PrimaryDepartment != null && SecondaryDepartment != null) {
                            (profileProvider.position == null || profileProvider.position == "Not a Member")
                                ? _ApplyToRobu()
                                : Fluttertoast.showToast(msg: "You are already a member...");
                            // // add method mamma....
                          } else {
                            Fluttertoast.showToast(
                                msg: "Please provide all required data...");
                          }
                        },
                        child: Text(
                          "Submit",
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
      ),
    );
  }
}
