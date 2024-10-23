import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:robu/Drawer_menu/about_details/projects.dart';


class Profile {
  final String name;
  final String? description;
  final String? imagePath;
  final Uri? profileUrl;

  Profile({
    required this.name,
    this.description,
    this.imagePath,
    this.profileUrl,
  });
}

class Banner {
  final String? imagePath;
  Banner({
    this.imagePath,
  });
}


class Department {
  final String? name;
  final String? description;
  final String? imagePath;

  Department({
    this.name,
    this.description,
    this.imagePath,
  });
}

final List<Profile> profiles = [
  Profile(
    name: 'Ratul Hasan',
    description:
    'Hello amazing Robu people.\nI am Introducing to you the Robotics Club(ROBU) App, a brainchild born out of a shared passion for technology, innovation, and a burning desire to make our club experience even more extraordinary.',
    imagePath: 'assets/dev/ratul.jpg',
    profileUrl: Uri.parse('https://www.github.com/onnesok'),
  ),
];



final List<Banner> banners = [
  Banner(
    imagePath: 'assets/banner/gallery.jpg',
  ),
];



final List<Department> departments = [
  Department(
    name: 'Department 1',
    description: 'Description of Department 1',
    imagePath: 'assets/banner/test.jpg',
  ),
  Department(
    name: 'Department 2',
    description: 'Description of Department 2',
    imagePath: 'assets/banner/test.jpg',
  ),
];