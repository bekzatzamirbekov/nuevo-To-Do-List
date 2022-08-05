import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: const Text('Home Page'),
          centerTitle: true,
        ),
        body: Center(
          child: Row(
            children: [
              Row(
                children: [
                  Row(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 120),
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/todo', (route) => true);
                              },
                              child: const Text('Open all my task lists')),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
