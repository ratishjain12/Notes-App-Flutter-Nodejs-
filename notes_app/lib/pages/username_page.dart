import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notes_app/pages/homepage.dart';

class UsernamePage extends StatefulWidget {
  const UsernamePage({super.key});

  @override
  State<UsernamePage> createState() => _UsernamePageState();
}

class _UsernamePageState extends State<UsernamePage> {
  TextEditingController usernameController = TextEditingController();

  void addToLocalStorage(String username) async {
    final userBox = Hive.box("userdata");
    userBox.put("username", username);
    Navigator.pushReplacement(
        context, CupertinoPageRoute(builder: (context) => const HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes App"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                  hintText: "Enter name", border: OutlineInputBorder()),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: MaterialButton(
              onPressed: () {
                addToLocalStorage(usernameController.text);
              },
              minWidth: double.infinity,
              color: const Color.fromARGB(255, 30, 92, 199),
              height: 50,
              child: const Text(
                "Submit",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          )
        ],
      ),
    );
  }
}
