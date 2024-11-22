import 'package:flutter/material.dart';

class Recruitment extends StatelessWidget {
  const Recruitment({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Integrate submit api here
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
      body: Center(child: Text("Nothing here")),
    );
  }
}
