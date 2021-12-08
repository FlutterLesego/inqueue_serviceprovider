// ignore_for_file: use_key_in_widget_constructors, avoid_unnecessary_containers, avoid_print

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inqueue/pages/forgotpassword.dart';
//import 'package:inqueue/pages/homescreen.dart';
import 'package:email_validator/email_validator.dart';
import 'homescreen.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = "login";

  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  var emailController = TextEditingController(text: "");
  var passwordController = TextEditingController(text: "");
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
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
                              const EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 0.0),
                          child: const Text('Log in',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 45.0,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.only(
                          top: 35.0, left: 20.0, right: 20.0),
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 10.0),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.always,
                            validator: (emailController) => emailController !=
                                        null &&
                                    !EmailValidator.validate(emailController)
                                ? 'Email address required'
                                : null,
                            textInputAction: TextInputAction.next,
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
                                    borderSide:
                                        BorderSide(color: Colors.green))),
                          ),
                          const SizedBox(height: 10.0),
                          const SizedBox(height: 20.0),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (passwordController) {
                              if (passwordController == null ||
                                  passwordController.isEmpty) {
                                return 'Password required';
                              } else if (passwordController.length < 6) {
                                return 'Password must have at least 6 characters';
                              } else if (passwordController
                                  .contains(r'(?=.*?[#?!@$%^&-_])')) {
                                return 'Password must have at least one special character';
                              } else {
                                return null;
                              }
                            },
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: _isVisible
                                      ? const Icon(
                                          Icons.visibility,
                                          color: Colors.green,
                                        )
                                      : const Icon(Icons.visibility_off,
                                          color: Colors.green),
                                  onPressed: () {
                                    setState(() {
                                      _isVisible = !_isVisible;
                                    });
                                  },
                                ),
                                icon: const Icon(
                                  Icons.lock_outline,
                                  color: Colors.green,
                                ),
                                labelText: 'PASSWORD',
                                labelStyle: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.green))),
                            obscureText: _isVisible == false ? true : false,
                          ),
                          const SizedBox(height: 15.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Forgotpassword()));
                                },
                                child: const Text(
                                  'Forgot Password',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                              IconButton(
                                padding: const EdgeInsets.only(top: 17),
                                onPressed: () async {
                                  final form = formKey.currentState!;

                                  if (form.validate()) {
                                    Fluttertoast.showToast(
                                      backgroundColor: Colors.transparent,
                                      textColor: Colors.green,
                                      msg: 'Logging in...',
                                      fontSize: 20,
                                    );
                                      // loginAndAuthenticateUser(context
                                      //   );
                                        Navigator.pushAndRemoveUntil(
                                            (context),
                                            MaterialPageRoute(builder: (context) => const Homescreen()),
                                            (route) => false);
                                      
                                  }
                                },
                                disabledColor: Colors.green,
                                color: Colors.green,
                                focusColor: Colors.green,
                                splashColor: Colors.green,
                                icon: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                ),
                                iconSize: 35,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20.0),
                        ],
                      )),
                  const SizedBox(height: 100.0),
                ],
              ),
            ),
          ),
        ));
  }
// void displayToastMsg(String message, BuildContext context) {
//     Fluttertoast.showToast(msg: message);
//   } // display toast

//   final FirebaseAuth __firebaseAuth = FirebaseAuth.instance;

//   void loginAndAuthenticateUser(BuildContext context) async {
//     showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext cntxt) {
//           return const SnackBar(content: Text( "Company image required"));
//         });

//     final User? firebaseUser = (await __firebaseAuth
//             .signInWithEmailAndPassword(
//                 email: emailController.text,
//                 password: passwordController.text)
//             .catchError((errorMsg) {
//       //Close Dialog
//       Navigator.pop(context);
//       displayToastMsg("errorMsg" + errorMsg.toString(), context);
//     }))
//         .user;

//     //Check if user exists
//     if (firebaseUser != null) {
//       //Save data
//       usersRef.child(firebaseUser.uid).once() //eventListener
//           .then((DataSnapshot snap) {
//         //If record exists in database
//         if (snap.value != null) {
//           //proceed to main screen
//           Navigator.pushNamedAndRemoveUntil(
//               context, Homescreen.routeName, (route) => false);
//           displayToastMsg("User Logged In!!!", context);
//         } else {
//           Navigator.pop(context);
//           //if record does exist, sign user out
//           __firebaseAuth.signOut();
//           displayToastMsg(
//               "User not found. Please create new account.", context);
//         }
//       });
//       //message

//       //redirect

//     } else {
//       Navigator.pop(context);
//       //Error and display error message
//       displayToastMsg("Error Occurred: User cannot be signed in.", context);
//     }
//   }
}
