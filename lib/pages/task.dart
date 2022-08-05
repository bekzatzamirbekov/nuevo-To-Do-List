// ignore_for_file: camel_case_types, must_be_immutable

import 'package:flutter/material.dart';

import 'dart:core';
// import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:calendar_appbar/calendar_appbar.dart';
// import 'package:flutter/show';
import 'package:firebase_core/firebase_core.dart';

class task extends StatefulWidget {
  task({Key? key}) : super(key: key);

  @override
  State<task> createState() => _taskState();
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

class _taskState extends State<task> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orgonize your day'),
        centerTitle: true,
        // actions: [
        //   Center(
        //       child: IconButton(
        //           onPressed: () {
        //             _menuOpen(context);
        //           },
        //           icon: const Icon(Icons.menu_rounded)))
        // ],
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
