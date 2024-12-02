import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_firebase_example_ef/email_password/email_login.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text("Home"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _auth.signOut().then((value) => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => EmailLoginPage())));
        },
        child: const Icon(Icons.power_settings_new_sharp),
      ),
    );
  }
}
