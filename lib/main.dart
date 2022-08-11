// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:last_auth/pages/home.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'screens/login_screen.dart';

// import 'auth_service.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); //initilization of Firebase app
  // here, Firebase.initilizeApp() is Future method, so you need to add await before.
  //run time error: Unhandled Exception: [core/no-app]
  //No Firebase App '[DEFAULT]' has been created - call Firebase.initializeApp()
  // final _auth = FirebaseAuth.instance;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale('en', ''),
      title: 'Email and Password Login',
      themeMode: ThemeMode.dark,
      theme: ThemeData(primarySwatch: Colors.lightBlue,
      visualDensity: VisualDensity.adaptivePlatformDensity,),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/todo': (context) => const Home(),
        '/calen': (context) => Calendar()
      },
    );
  }
}
