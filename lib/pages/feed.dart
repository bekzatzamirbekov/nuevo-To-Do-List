import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Feed extends StatefulWidget {
  Feed({Key? key}) : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

late String userToDo;
List todoList = [];
void initFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

void initState() {
  initState();
  initFirebase();
  todoList.add('value');
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     // title:
      //     // const Text('Organize your day', style: TextStyle(fontSize: 20)),
      //     // centerTitle: true,
      //     actions: const []),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Items').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text(
                  "click the green button and create your tasks for free",
                  style: TextStyle(color: Colors.black),
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
                          icon: const Icon(
                            Icons.done,
                            color: Colors.green,
                            size: 30,
                            semanticLabel: 'done',
                          ),
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
