// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:new_firebase_example_ef/otp/homepage.dart';
import 'package:new_firebase_example_ef/otp/widget/button.dart';

import 'package:pinput/pinput.dart';

class VerifyOtpScreen extends StatefulWidget {
  String verificationId;
  VerifyOtpScreen({super.key, required this.verificationId});
  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final TextEditingController _pinPutController = TextEditingController();
  String? pinnumber;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool showLoading = false;

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
      });

      if (authCredential.user != null) {
        log("SUCCESS ----------------------------------------------------------");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message.toString()),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      SizedBox(
        width: double.infinity,
        child: Lottie.asset(
          "assets/otpverification.json",
          height: 300.0,
          width: 250.0,
        ),
      ),
      Stack(children: [
        Container(
          height: size.height * 0.45,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10.0,
                spreadRadius: 0.0,
                offset: const Offset(2.0, 5.0),
              ),
            ],
          ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 10.0,
            margin: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 40.0),
                    padding: const EdgeInsets.all(20.0),
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(children: <TextSpan>[
                          TextSpan(
                            text: "Verification\n\n",
                            style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0278AE),
                            ),
                          ),
                          TextSpan(
                              text: "Enter the OTP send to your mobile number",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Color(0xFF373A40),
                              ))
                        ]))),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Pinput(
                    length: 6,
                    defaultPinTheme: PinTheme(
                        height: 50,
                        width: 60,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.purple.shade600,
                          ),
                        )),
                    controller: _pinPutController,
                    pinAnimationType: PinAnimationType.fade,
                    onChanged: (pin) {
                      log("inside onchange ===$pin");
                      setState(() {
                        pinnumber = pin;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Button(
            size: size,
            text: "Continue",
            press: () {
              PhoneAuthCredential phoneAuthCredential =
                  PhoneAuthProvider.credential(
                      verificationId: widget.verificationId,
                      smsCode: pinnumber.toString());

              signInWithPhoneAuthCredential(phoneAuthCredential);
            })
      ])
    ])));
  }
}
