# ROBU App

The **ROBU App** is designed for the Robotics Club of BRAC University (ROBU) to provide members with a unified platform for accessing resources, events, and announcements. This app is built using **Flutter** and includes interactive and dynamic UI components to enhance the user experience.

---

## Features

- **Robotics Basics**: Learn about the fundamentals of robotics with categorized lessons.
- **Events and Announcements**: Stay updated with the latest ROBU events and announcements.
- **Blood Bank**: Find and connect with donors in the ROBU network.
- **Registration**: Easy access to club registrations for events and memberships.
- **Alumni Section**: Discover and connect with alumni who shaped the club's journey.
- **Panel info**: All the Info you need about DADS.
- **Dynamic UI**: Engaging and animated interfaces for seamless navigation.
- **Expandable Categories**: Organized categories like Coding, Hardware Projects, and more.

---
<!--
lib/
├── main.dart                  // App entry point
├── models/
│   ├── info_block.dart        // Manages categories data
│   └── banner.dart            // Manages banners data
├── screens/
│   ├── info_home.dart         // Main screen for navigation
│   └── home_contents.dart     // Entire UI of home section
├── widgets/
│   ├── category_view.dart     // Grid-based category view
│   └── custom_banner.dart     // Custom banner widget
└── utils/
    └── bor.dart               // URL handling with headers
-->

## Screens Overview

1. **InfoHome Screen**:
   - A central hub that organizes and navigates between sections like robotics basics, events, blood bank, panel, and announcements.
   - Uses a `CategoryView` widget in a grid layout with animation.

2. **InfoBlock**:
   - Manages categories with fields like title, imagePath, lessonCount, money, and rating.
   - Example Categories: Robotics Basics, Coding, Hardware Projects.

3. **Banner**:
   - Displays project banners for categories like coding, hardware projects, and more.

---

## Technologies Used

- **Flutter**: For the mobile app's front-end development.
- **Dart**: Programming language used for building the app.
---

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/Onnesok/robu-app.git
   cd robu-app
