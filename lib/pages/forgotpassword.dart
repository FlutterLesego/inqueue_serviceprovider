// ignore_for_file: use_key_in_widget_constructors, avoid_unnecessary_containers
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'auth_screen.dart';

class Forgotpassword extends StatefulWidget {
  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  var emailController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.green,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        padding:
                            const EdgeInsets.fromLTRB(15.0, 50.0, 0.0, 0.0),
                        child: const Text('Reset',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 45.0,
                                fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 105.0, 0.0, 0.0),
                        child: const Text('Password',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 45.0,
                                fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        padding:
                            const EdgeInsets.fromLTRB(245.0, 100.0, 0.0, 0.0),
                        child: const Text('.',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 50.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.green)),
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 18.0, right: 15.0),
                  child: Text(
                    "Please enter your email address to reset password",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.only(
                        top: 25.0, left: 20.0, right: 20.0),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: emailController,
                          autovalidateMode: AutovalidateMode.always,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email address required';
                            } else if (!value.contains('@') ||
                                !value.contains('.')) {
                              return 'Email address invalid';
                            } else {
                              return null;
                            }
                          },
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              icon: Icon(
                                Icons.email_outlined,
                                color: Colors.green,
                              ),
                              labelText: 'EMAIL ADDRESS',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green))),
                        ),
                        const SizedBox(height: 15.0),
                        IconButton(
                          padding: const EdgeInsets.only(top: 17),
                          onPressed: () async {
                            try {
                              await FirebaseAuth.instance
                                  .sendPasswordResetEmail(
                                      email: emailController.text.trim())
                                  .then((value) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AuthScreen()));
                                Fluttertoast.showToast(
                                    msg: "Email sent successfully!")
                                ;
                              });
                            } catch (error) {
                              Fluttertoast.showToast(
                                  msg: "Email address not found");
                              Fluttertoast.showToast(
                                  msg: "Please create a new account");
                            }
                          },
                          disabledColor: Colors.green,
                          color: Colors.green,
                          focusColor: Colors.green,
                          splashColor: Colors.green,
                          icon: const Icon(
                            Icons.arrow_forward_ios_outlined,
                          ),
                          iconSize: 35,
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ));
  }
}
