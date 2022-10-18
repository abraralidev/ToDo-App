// ignore_for_file: unnecessary_string_interpolations

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/Model/user.dart';
import 'package:todo/user_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final textcontrolor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const UserPage()));
        }),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(title: const Text("All USERS")),
      body: StreamBuilder<List<User>>(
        stream: readUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final users = snapshot.data!;
            return ListView(
              children: users.map(buildUser).toList(),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Stream<List<User>> readUsers() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());

  Widget buildUser(User user) => ListTile(
        leading: CircleAvatar(child: Text("${user.age}")),
        title: Text(user.name),
        subtitle: Text(user.birthday),
        trailing: SingleChildScrollView(
          child: Column(
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  final docUser =
                      FirebaseFirestore.instance.collection('users').doc();
                  docUser.update({
                    'name': 'ahmad',
                  });
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {
                  final docUser =
                      FirebaseFirestore.instance.collection('users').doc();
                  docUser.delete();
                },
              ),
            ],
          ),
        ),
      );
}

// That is used for Upload data in the json form

// Future createuser({required String name}) async {
//   final docUser = FirebaseFirestore.instance.collection('users').doc('my-id');
//   final json = {
//     'name': name,
//     'age': 21,
//     'birthday': DateTime(2002, 11, 5),
//   };
//   await docUser.set(json);
// }


// Future createuser({required String name}) async {
//   final docUser = FirebaseFirestore.instance.collection('users').doc();
//   final user = User(
//     id: docUser.id,
//     age: 21,
//     birthday: "2002, 11, 5",
//     name: name,
//   );
//   final json = user.toJson();
//   await docUser.set(json);
// }
