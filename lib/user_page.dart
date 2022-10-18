import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/Screens/home.dart';


import 'Model/user.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final controllorName = TextEditingController();
  final controllorage = TextEditingController();
  final controllorDate = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add User"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: controllorName,
            decoration: decoration("Name"),
          ),
          const SizedBox(
            height: 25,
          ),
          TextField(
            controller: controllorage,
            decoration: decoration("Age"),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(
            height: 25,
          ),
          TextField(
            controller: controllorDate,
            decoration: decoration("Birthday"),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                final user = User(
                    name: controllorName.text,
                    age: int.parse(controllorage.text),
                    birthday: controllorDate.text);
                createUser(user);
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>const Home()));
                  
              },
              child: const Text("Create"))
        ],
      ),
    );
  }
}

Future createUser(User user) async {
  final docUser = FirebaseFirestore.instance.collection('users').doc();
  user.id = docUser.id;
  final json = user.toJson();
  await docUser.set(json);
}

decoration(String s) {
  return InputDecoration(
      labelText: s,
      filled: true,
      fillColor: const Color.fromARGB(255, 243, 243, 243),
      focusedBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: Color.fromARGB(255, 236, 236, 236)),
          borderRadius: BorderRadius.circular(20)),
      enabledBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: Color.fromARGB(255, 236, 236, 236)),
          borderRadius: BorderRadius.circular(20)));
}
