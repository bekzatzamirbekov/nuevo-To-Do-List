import 'package:flutter/material.dart';

class Liked extends StatefulWidget {
  Liked({Key? key}) : super(key: key);

  @override
  State<Liked> createState() => _LikedState();
}

class _LikedState extends State<Liked> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        child: Text(
          'coming soon',
          style: TextStyle(fontSize: 50),
        ),
      )),
    );
  }
}
