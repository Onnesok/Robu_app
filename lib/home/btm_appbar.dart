import 'package:flutter/material.dart';
import 'package:robu/home/home_contents.dart';
import 'package:robu/info_pages/events.dart';
import 'package:robu/themes/app_theme.dart';

class CustomBottomAppBar extends StatefulWidget {
  const CustomBottomAppBar({super.key});

  @override
  _CustomBottomAppBarState createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      HomeContents(),
      Events(),
    ];

    final bottomNavBarItems = const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person_outline),
        label: 'Profile',
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: widgetOptions[_selectedIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.white,
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
          child: BottomNavigationBar(
            items: bottomNavBarItems,
            currentIndex: _selectedIndex,
            selectedItemColor: AppTheme.blueaccent,
            unselectedItemColor: Colors.black87,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
