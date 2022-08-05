import 'package:flutter/material.dart';
import 'package:newtasklist/pages/home.dart';
// import 'package:newtasklist/pages/tuthome.dart';
import 'package:newtasklist/pages/mainscreen.dart';
import 'package:newtasklist/pages/calendar.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    theme: ThemeData(primaryColor: Colors.deepOrangeAccent),
    initialRoute: '/',
    routes: {
      '/todo': (context) => Home(),
      '/': (context) => const MainScreen(),
      '/calen': (context) => const DemoApp()
      // '/home':(context) => TutorialHome()
    },
  ));
}
