import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:new_firebase_example_ef/otp/otp.dart';
import 'package:new_firebase_example_ef/otp/widget/button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  String? verificationId;

  bool showLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: size.height * 0.05),
                child: Lottie.asset(
                  "assets/otp.json",
                  height: size.height * 0.4,
                  alignment: Alignment.bottomCenter,
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
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 10.0,
                    margin: const EdgeInsets.all(12.0),
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: const TextSpan(
                                style: TextStyle(
                                  fontSize: 13.0,
                                  color: Colors.black,
                                  letterSpacing: 0.5,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "Login with mobile number\n\n\n",
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF0278AE),
                                    ),
                                  ),
                                  TextSpan(
                                    text: "We will send you an",
                                    style: TextStyle(
                                      color: Color(0xFF373A40),
                                    ),
                                  ),
                                  TextSpan(
                                    text: " One Time Password (OTP) ",
                                    style: TextStyle(
                                      color: Color(0xFF373A40),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(text: "on this mobile number"),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: size.height * 0.045),
                            child: Padding(
                              padding: EdgeInsets.all(4.0),
                              child: TextFormField(
                                controller: phoneController,
                                keyboardType: TextInputType.phone,
                                decoration: const InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFD4D4D4),
                                      width: 1.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFD4D4D4),
                                      width: 1.0,
                                    ),
                                  ),
                                  hintText: "Enter Your Mobile Number.",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Button(
                    size: size,
                    text: "Next",
                    press: () async {
                      setState(() {
                        showLoading = true;
                      });

                      await _auth.verifyPhoneNumber(
                        phoneNumber: "+91" + phoneController.text,
                        verificationCompleted: (phoneAuthCredential) async {
                          setState(() {
                            showLoading = false;
                          });
                          //signInWithPhoneAuthCredential(phoneAuthCredential);
                        },
                        verificationFailed: (verificationFailed) async {
                          setState(() {
                            showLoading = false;
                          });
                          log(verificationFailed.message.toString());
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                Text(verificationFailed.message.toString()),
                          ));
                        },
                        codeSent: (verificationId, resendingToken) async {
                          setState(() {
                            showLoading = false;
                            // currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;

                            this.verificationId = verificationId;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VerifyOtpScreen(
                                          verificationId: verificationId,
                                        )));
                          });
                        },
                        codeAutoRetrievalTimeout: (verificationId) async {},
                      );
                    })
              ])
            ])));
  }
}
