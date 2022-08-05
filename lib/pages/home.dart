// ignore_for_file: avoid_print, unused_element

import 'dart:core';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:newtasklist/pages/calendar.dart';
import 'package:newtasklist/pages/mainscreen.dart';

// import 'package:english_words/english_words.dart';
// ignore: avoid_web_libraries_in_flutter
// import 'package:calendar_appbar/calendar_appbar.dart';
// import 'package:flutter/show';
// import 'package:newtasklist/main.dart';
// ignore: must_be_immutable
class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();

  List todoList = [];
  void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    todoList.addAll([
      'go home',
      'go home',
      'go home',
    ]);
  }

  void initState() {
    initState();
    initFirebase();
  }
}
late String userToDo;

void _menuOpen(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Menu'),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (route) => false);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: const [
                        Text('To home screen'),
                      ],
                    ),
                  )),
              const Padding(padding: EdgeInsets.only(left: 15))
            ],
          ),
        ));
  }));
}

// void _calerOpen(BuildContext context){
//   NavigationBarTheme.of(context).iconTheme!(MaterialPageRoute((builder = BuildContext context)) {
//     return Scaffold(
//     );
//    });
// }
class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
          title:
              const Text('Organize your day', style: TextStyle(fontSize: 20)),
          centerTitle: true,
          actions: const []),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.only(left: 1.0),
          child: Container(
            color: Colors.blueGrey,
            child: ListView(
              children: [
                const DrawerHeader(
                    child: Center(
                  child: Text(
                    'MENU',
                    style: TextStyle(fontSize: 35, color: Colors.white),
                  ),
                )),
                ListTile(
                  iconColor: Colors.white,
                  leading: const Icon(
                    Icons.home,
                  ),
                  title: const Text('Main Screen',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const MainScreen())),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                ),
                ListTile(
                  iconColor: Colors.white,
                  leading: const Icon(Icons.edit_calendar),
                  title: const Text('Calendar',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const DemoApp())),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                ),
                ListTile(
                  iconColor: Colors.white,
                  leading: const Icon(Icons.favorite),
                  title: const Text('Favourites',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const DemoApp())),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                ),
                ListTile(
                  iconColor: Colors.white,
                  leading: const Icon(Icons.support_agent_outlined),
                  title: const Text('Support',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const DemoApp())),
                )
              ],
            ),
          ),
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Items').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: Text(
                  "click the green button and create your tasks for free",
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                    key: Key(snapshot.data!.docs[index].id),
                    child: Card(
                      child: ListTile(
                        title: Text(snapshot.data!.docs[index].get('item')),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_sweep_sharp),
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection('Items')
                                .doc(snapshot.data!.docs[index].id)
                                .delete();
                          },
                        ),
                      ),
                    ),
                    onDismissed: (direction) {
                      FirebaseFirestore.instance
                          .collection('Items')
                          .doc(snapshot.data!.docs[index].id)
                          .delete();
                    },
                  );
                });
          }),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
          child: GNav(
              tabBackgroundColor: Colors.blue,
              // color: Colors.white,
              activeColor: Colors.white,
              padding: const EdgeInsets.all(16),
              gap: 9,
              // onTabChange: _menuOpen(context),
              tabs: [
                const GButton(icon: Icons.home, text: 'Home'),
                const GButton(
                  icon: Icons.assignment,
                  text: 'Tasks',
                ),
                GButton(
                  icon: Icons.calendar_month_outlined,
                  text: 'Calendar',
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(
                      context,
                      '/calen',
                    );
                  },
                ),
                GButton(
                    icon: Icons.settings,
                    text: 'Settings',
                    onPressed: () {
                      // _menuOpen(context);
                    })
              ],
              backgroundColor: Colors.white),
        ),
      ),
      // backgroundColor: Colors.grey[900],
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Add element'),
                    content: TextField(
                      onChanged: (String value) {
                        userToDo = value;
                      },
                    ),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection('Items')
                                .add({'item': userToDo});
                            Firebase.initializeApp();
                            Navigator.of(context).pop();
                          },
                          child: const Text('Add'))
                    ],
                  );
                });
          },
          child: const Icon(
            Icons.add_circle_sharp,
            color: Colors.white,
          )),
    );
  }
}
