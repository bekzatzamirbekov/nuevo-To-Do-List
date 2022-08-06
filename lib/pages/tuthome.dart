import 'dart:core';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// import 'package:flutter/show';
// import 'package:firebase_core/firebase_core.dart';
class TutorialHome extends StatelessWidget {
  const TutorialHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Scaffold является разметкой для основных компонентов Material.
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.swipe_left_sharp),
          tooltip: 'Back',
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushNamedAndRemoveUntil(
                context, '/todo', (route) => false);
          },
        ),
        title: const Text('Example title'),
        actions: const <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          ),
        ],
      ),
      // body - это большая часть экрана.
      body: const Center(
        child: Text('Hello, world!'),
      ),
      floatingActionButton: const FloatingActionButton(
        tooltip: 'Add',
        onPressed: null, // используются вспомогательные технологии
        child: Icon(Icons.add),
      ),
    );
  }
}
