// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
// import 'package:newtasklist/login/login.dart';
// import 'package:newtasklist/login/sign_up.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.grey[900],
        body: Container(
      child: Center(
        child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/todo', (route) => true);
            },
            child: const Text('Open all my task lists')),
      ),
    ));
  }
}
