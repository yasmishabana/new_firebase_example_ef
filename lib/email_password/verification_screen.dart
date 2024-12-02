import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_firebase_example_ef/otp/homepage.dart';

class EmailVerificationScreen extends StatefulWidget {
  String email;
  EmailVerificationScreen({super.key, required this.email});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  late Timer timer;
  @override
  void initState() {
    // _auth.currentUser?.sendEmailVerification();
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      log("reload");
      _auth.currentUser?.reload();
      log("_auth.currentUser?.emailVerified ==== ${_auth.currentUser!.emailVerified}");
      if (_auth.currentUser?.emailVerified == true) {
        // _auth.currentUser?.email.toString();
        log("verified ------------------------------------------");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/email-verification.jpg"),
            const Text(
              "Confirm your email address",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("We sent a confirmation email to:"),
            Text(
              widget.email.toString(),
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const Text(
              "Check your email and click on the\n confirmation link to continue.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
                onTap: () {
                  _auth.currentUser?.sendEmailVerification();
                },
                child: const Text(
                  "Resend Email",
                  style: TextStyle(fontSize: 15, color: Colors.blue),
                ))
          ],
        ),
      ),
    );
  }
}
