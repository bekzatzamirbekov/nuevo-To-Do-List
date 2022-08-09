// ignore_for_file: avoid_print, unused_element
import 'dart:core';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:last_auth/model/user_model.dart';
import 'package:last_auth/pages/calendar.dart';
import 'package:last_auth/pages/important.dart';
import 'package:last_auth/pages/task.dart';
import 'package:last_auth/screens/login_screen.dart';
import 'package:last_auth/tabs.dart';
import 'feed.dart';
import 'mainscreen.dart';

// import 'package:calendar_appbar/calendar_appbar.dart';
// import 'package:flutter/show';
// import 'package:last_auth/main.dart';
// ignore: must_be_immutable
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

mixin PersistentTabController {}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  // --------------------------------------
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  // ---------------------------------------------------
  int index = 0;
  final screens = [Feed(), Calendar(), Liked(), MainScreen()];
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);

    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });

    // dispose function
    @override
    void dispose() {
      super.dispose();
      tabController.dispose();
    }

    Future<void> logout(BuildContext context) async {
      final itemEditingController = TextEditingController();

      final itemField = TextFormField(
        autofocus: false,
        controller: itemEditingController,
        onSaved: (value) {
          itemEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
      );

      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: ((context) => const LoginScreen())));
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
          title:
              const Text('Create your tasks', style: TextStyle(fontSize: 20)),
          centerTitle: true,
          actions: const []),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.only(left: 0.0),
          child: Container(
            color: Colors.white10,
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(
                    '${loggedInUser.firstName}',
                    style: TextStyle(color: Colors.white),
                  ),
                  accountEmail: Text(
                    '${user?.email}',
                    style: TextStyle(color: Colors.white),
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage(
                      'assets/userlogo.png',
                    ),
                    backgroundColor: Colors.yellow,
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/backg.jpg",
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                ListTile(
                  iconColor: Colors.black,
                  leading: const Icon(
                    Icons.home,
                  ),
                  title: const Text('Main Screen',
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const MainScreen())),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                ),
                ListTile(
                  iconColor: Colors.green,
                  leading: const Icon(Icons.edit_calendar),
                  title: const Text('Calendar',
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                  onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const DemoApp())),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                ),
                ListTile(
                  iconColor: Colors.red,
                  leading: const Icon(
                    Icons.favorite,
                  ),
                  title: const Text('Favourites',
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => MyTabs())),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                ),
                ListTile(
                  iconColor: Colors.blue,
                  leading: const Icon(Icons.support_agent_outlined),
                  title: const Text('Support',
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const MainScreen())),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                ),
                ListTile(
                    iconColor: Colors.redAccent,
                    leading: const Icon(Icons.logout),
                    title: const Text('Log out',
                        style: TextStyle(fontSize: 20, color: Colors.black)),
                    onTap: () => Navigator.of(context).pushAndRemoveUntil<void>(
                          MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const LoginScreen()),
                          ModalRoute.withName('/'),
                        )),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
              indicatorColor: Colors.blue.shade100,
              labelTextStyle: MaterialStateProperty.all(
                  TextStyle(fontSize: 14, fontWeight: FontWeight.w500))),
          child: NavigationBar(
            backgroundColor: Colors.white24,
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            height: 60,
            animationDuration: Duration(seconds: 1),
            selectedIndex: index,
            onDestinationSelected: (index) => setState(() {
              this.index = index;
            }),
            destinations: [
              NavigationDestination(
                icon: Icon(
                  Icons.home_outlined,
                  size: 30,
                ),
                label: 'ToDo',
                selectedIcon: Icon(
                  Icons.home,
                  size: 30,
                ),
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.calendar_month_outlined,
                  size: 30,
                ),
                label: 'Calendar',
                selectedIcon: Icon(
                  Icons.calendar_month,
                  size: 30,
                ),
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.favorite_border_outlined,
                  size: 30,
                ),
                label: 'Important',
                selectedIcon: Icon(
                  Icons.favorite_rounded,
                  size: 30,
                ),
              ),
              NavigationDestination(
                icon: Icon(Icons.settings_outlined, size: 30),
                label: 'Settings',
                selectedIcon: Icon(
                  Icons.settings,
                  size: 30,
                ),
              ),
            ],
          )),
      backgroundColor: Colors.white,
      body: screens[index]
      // PageView(
      //   controller: controller,
      //   onPageChanged: (index) {
      //     screens[index];
      //   },
      //   children: [
      //     Container(
      //       child: Feed(),
      //     ),
      //     Container(
      //       child: Image(
      //         image: AssetImage('assets/back.png'),
      //         fit: BoxFit.cover,
      //       ),
      //     ),
      //     Container(
      //       child: Liked(),
      //     ),
      //     Container(
      //       child: MainScreen(),
      //     ),
      //     screens[index]
      //   ],
      // ),
      // screens[index],
      );
}
