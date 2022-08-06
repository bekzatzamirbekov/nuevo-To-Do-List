// ignore_for_file: avoid_print, unused_element
import 'dart:core';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:last_auth/model/user_model.dart';
import 'package:last_auth/pages/calendar.dart';
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
void initFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

void initState() {
  initState();
  initFirebase();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  // ---------------------------------------------------
  int index = 0;
  final screens = [
    Feed(),
    Image(
      image: AssetImage('assets/back.png'),
      fit: BoxFit.cover,
    ),
    Liked(),
    MainScreen()
  ];
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);

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

/*
    @override
    Widget build(BuildContext context) => Scaffold(
          // backgroundColor: Colors.black,
          appBar: AppBar(
              title: const Text('Make tasks and lists',
                  style: TextStyle(fontSize: 20)),
              centerTitle: true,
              actions: const []),
          drawer: Drawer(
            child: Padding(
              padding: const EdgeInsets.only(left: 0.0),
              child: Container(
                color: Colors.white10,
                child: ListView(
                  children: [
                    DrawerHeader(
                        child: Center(
                      child: Text(
                        '${loggedInUser.email}',
                        style:
                            const TextStyle(fontSize: 28, color: Colors.black),
                      ),
                    )),
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
                      iconColor: Colors.black,
                      leading: const Icon(Icons.edit_calendar),
                      title: const Text('Calendar',
                          style: TextStyle(fontSize: 20, color: Colors.black)),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const DemoApp())),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                    ),
                    ListTile(
                      iconColor: Colors.black,
                      leading: const Icon(Icons.favorite),
                      title: const Text('Favourites',
                          style: TextStyle(fontSize: 20, color: Colors.black)),
                      onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => MyTabs())),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                    ),
                    ListTile(
                      iconColor: Colors.black,
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
                        iconColor: Colors.black,
                        leading: const Icon(Icons.logout),
                        title: const Text('Log out',
                            style:
                                TextStyle(fontSize: 20, color: Colors.black)),
                        onTap: () =>
                            Navigator.of(context).pushAndRemoveUntil<void>(
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
          bottomNavigationBar: Container(
            child: TabBar(
              controller: tabController,
              tabs: <Tab>[
                Tab(icon: Icon(FontAwesomeIcons.angleUp), text: 'Feed'),
                Tab(
                  icon: Icon(FontAwesomeIcons.tags),
                  text: 'Tasks',
                ),
                Tab(
                  icon: Icon(FontAwesomeIcons.calendar),
                  text: 'Calendar',
                ),
                Tab(
                  icon: Icon(FontAwesomeIcons.slack),
                  text: 'Settings',
                )
              ],
            ),
          ),
          // backgroundColor: Colors.grey[900],
          body: TabBarView(
            controller: tabController,
            children: [
              Feed(),
              Calendar(),
            ],
          ),
        );
  
  
  }
*/
    Future<void> logout(BuildContext context) async {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: ((context) => const LoginScreen())));
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        // backgroundColor: Colors.black,
        appBar: AppBar(
            title: const Text('Create your tasks',
                style: TextStyle(fontSize: 20)),
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
                    accountName: Text('${loggedInUser.firstName}'),
                    accountEmail: Text('${loggedInUser.email}'),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: AssetImage(
                        'assets/userlogo.png',
                      ),
                      backgroundColor: Colors.transparent,
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
                  // DrawerHeader(
                  //     child: Center(
                  //         // child: Text(
                  //         //   '${loggedInUser.firstName}',
                  //         //   style: const TextStyle(fontSize: 28, color: Colors.black),
                  //         // ),
                  //         )),
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
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const DemoApp())),
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
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MyTabs())),
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
                      onTap: () =>
                          Navigator.of(context).pushAndRemoveUntil<void>(
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
              labelBehavior:
                  NavigationDestinationLabelBehavior.onlyShowSelected,
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
        body: screens[index],

        // TabBarView(
        //   controller: tabController,
        //   children: [
        //     Feed(),
        //     Calendar(),
        //   ],
        // ),
      );
}
/*
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
/*
    @override
    Widget build(BuildContext context) => Scaffold(
          // backgroundColor: Colors.black,
          appBar: AppBar(
              title: const Text('Make tasks and lists',
                  style: TextStyle(fontSize: 20)),
              centerTitle: true,
              actions: const []),
          drawer: Drawer(
            child: Padding(
              padding: const EdgeInsets.only(left: 0.0),
              child: Container(
                color: Colors.white10,
                child: ListView(
                  children: [
                    DrawerHeader(
                        child: Center(
                      child: Text(
                        '${loggedInUser.email}',
                        style:
                            const TextStyle(fontSize: 28, color: Colors.black),
                      ),
                    )),
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
                      iconColor: Colors.black,
                      leading: const Icon(Icons.edit_calendar),
                      title: const Text('Calendar',
                          style: TextStyle(fontSize: 20, color: Colors.black)),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const DemoApp())),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                    ),
                    ListTile(
                      iconColor: Colors.black,
                      leading: const Icon(Icons.favorite),
                      title: const Text('Favourites',
                          style: TextStyle(fontSize: 20, color: Colors.black)),
                      onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => MyTabs())),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                    ),
                    ListTile(
                      iconColor: Colors.black,
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
                        iconColor: Colors.black,
                        leading: const Icon(Icons.logout),
                        title: const Text('Log out',
                            style:
                                TextStyle(fontSize: 20, color: Colors.black)),
                        onTap: () =>
                            Navigator.of(context).pushAndRemoveUntil<void>(
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
          bottomNavigationBar: Container(
            child: TabBar(
              controller: tabController,
              tabs: <Tab>[
                Tab(icon: Icon(FontAwesomeIcons.angleUp), text: 'Feed'),
                Tab(
                  icon: Icon(FontAwesomeIcons.tags),
                  text: 'Tasks',
                ),
                Tab(
                  icon: Icon(FontAwesomeIcons.calendar),
                  text: 'Calendar',
                ),
                Tab(
                  icon: Icon(FontAwesomeIcons.slack),
                  text: 'Settings',
                )
              ],
            ),
          ),
          // backgroundColor: Colors.grey[900],
          body: TabBarView(
            controller: tabController,
            children: [
              Feed(),
              Calendar(),
            ],
          ),
        );
  
  
  }
*/

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: ((context) => const LoginScreen())));
  }
}
*/