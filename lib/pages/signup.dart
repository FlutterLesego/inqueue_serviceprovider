// ignore_for_file: use_key_in_widget_constructors, avoid_unnecessary_containers, unrelated_type_equality_checks, avoid_print, unused_import, deprecated_member_use, unused_local_variable, library_prefixes, prefer_const_constructors
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inqueue/global/global.dart';
import 'package:inqueue/main.dart';
import 'package:inqueue/models/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:inqueue/widgets/loadingdialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_screen.dart';

class Signup extends StatefulWidget {
  static const String routeName = "signup";

  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  //string for displaying error message
  String? errorMessage;

  bool isLoading = true;

  final formKey = GlobalKey<FormState>();

  var nameController = TextEditingController(text: "");
  var addressController = TextEditingController(text: "");
  var phoneController = TextEditingController(text: "");
  var emailController = TextEditingController(text: "");
  var passwordController = TextEditingController(text: "");
  var confirmpasswordController = TextEditingController(text: "");

  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();
  String completeAddress = "";

  Position? position;
  List<Placemark>? placeMarks;

  String serviceProviderImageUrl = "";

  Future<void> _getImage() async {
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      imageXFile;
    });
  }

  getCurrentLocation() async {
    LocationPermission locationPermission =
        await Geolocator.requestPermission();

    Position newPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    position = newPosition;

    placeMarks = await placemarkFromCoordinates(
      position!.latitude,
      position!.longitude,
    );

    Placemark pmark = placeMarks![0];

    completeAddress =
        '${pmark.subThoroughfare} ${pmark.thoroughfare}, ${pmark.subLocality} ${pmark.locality}, ${pmark.subAdministrativeArea}, ${pmark.administrativeArea} ${pmark.postalCode}, ${pmark.country}'; //get location step by step

    addressController.text = completeAddress;
  }

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
                          child: const Text('Getting Started',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 35.0,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        _getImage();
                      },
                      child: CircleAvatar(
                        radius: MediaQuery.of(context).size.width * 0.20,
                        backgroundColor: Colors.white70,
                        backgroundImage: imageXFile == null
                            ? null
                            : FileImage(File(imageXFile!.path)),
                        child: imageXFile == null
                            ? Icon(
                                Icons.add_photo_alternate,
                                size: MediaQuery.of(context).size.width * 0.20,
                                color: Colors.green,
                              )
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Container(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: nameController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Name required';
                              } else {
                                return null;
                              }
                            },
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.person,
                                  color: Colors.green,
                                ),
                                labelText: 'OPERATING AS',
                                labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.green))),
                          ),
                          const SizedBox(height: 10.0),
                          TextFormField(
                            controller: phoneController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Telephone number required';
                              } else if (value.length < 10 ||
                                  value.length > 10) {
                                return 'Invalid phone number';
                              } else {
                                return null;
                              }
                            },
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.phone,
                                  color: Colors.green,
                                ),
                                labelText: 'PHONE NUMBER',
                                labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.green))),
                          ),
                          const SizedBox(height: 10.0),
                          TextFormField(
                            controller: emailController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                                    borderSide:
                                        BorderSide(color: Colors.green))),
                          ),
                          const SizedBox(height: 10.0),
                          TextFormField(
                            controller: addressController,
                            enabled: true,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Location required';
                              } else {
                                return null;
                              }
                            },
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.location_on,
                                  color: Colors.green,
                                ),
                                labelText: 'LOCATION',
                                labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.green))),
                          ),
                          ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  primary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30))),
                              onPressed: () {
                                getCurrentLocation();
                              },
                              icon: const Icon(
                                Icons.location_searching,
                                color: Colors.green,
                              ),
                              label: const Text(
                                "get current location",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontFamily: 'Montseratt'),
                              )),
                          const SizedBox(height: 10.0),
                          TextFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password required';
                              } else if (value.length < 6) {
                                return 'Password must have at least 6 characters';
                              } else if (!value.toString().contains(
                                  RegExp(r'(?=.*?[#?!@$%^&-_])'), 1)) {
                                return 'Password must have at least one special character';
                              } else {
                                return null;
                              }
                            },
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.lock,
                                  color: Colors.green,
                                ),
                                labelText: 'PASSWORD',
                                labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.green))),
                            obscureText: true,
                          ),
                          const SizedBox(height: 10.0),
                          TextFormField(
                            controller: confirmpasswordController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value.toString() == passwordController.text) {
                                return null;
                              } else {
                                return 'Passwords do not match';
                              }
                            },
                            decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.lock,
                                  color: Colors.green,
                                ),
                                labelText: 'CONFIRM PASSWORD',
                                labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.green))),
                            obscureText: true,
                          ),
                          const SizedBox(height: 15.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                padding: const EdgeInsets.only(top: 17),
                                onPressed: () async {
                                  final form = formKey.currentState;

                                  if (form!.validate()) {
                                    if (imageXFile == null) {
                                      Fluttertoast.showToast(msg: "Company image required");
                                      
                                    }

                                    String fileName = DateTime.now()
                                        .millisecondsSinceEpoch
                                        .toString();
                                    fStorage.Reference reference = fStorage
                                        .FirebaseStorage.instance
                                        .ref()
                                        .child("ServiceProviderImages")
                                        .child(fileName);
                                    fStorage.UploadTask uploadTask = reference
                                        .putFile(File(imageXFile!.path));
                                    fStorage.TaskSnapshot taskSnapshot =
                                        await uploadTask.whenComplete(() {});
                                    await taskSnapshot.ref
                                        .getDownloadURL()
                                        .then((url) {
                                      serviceProviderImageUrl = url;
                                    });

                                    registerUser(
                                        nameController.text,
                                        phoneController.text,
                                        emailController.text,
                                        addressController.text,
                                        passwordController.text);
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
                  const SizedBox(height: 50.0),
                ],
              ),
            ),
          ),
        ));
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//register function
  void registerUser(String name, String phone, String email, String location,
      String password) async {
    if (formKey.currentState!.validate()) {
      try {
        await _firebaseAuth
            .createUserWithEmailAndPassword(
                email: emailController.text.trim(),
                password: passwordController.text.trim())
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Navigator.pop(context);
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Navigator.pop(context);
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = firebaseAuth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.name = nameController.text.trim();
    userModel.location = addressController.text.trim();
    userModel.phone = phoneController.text.trim();
    userModel.password = passwordController.text.trim();

    await firebaseFirestore
        .collection("service providers")
        .doc(user.email)
        .set({
      "ID": user.uid,
      "email": user.email,
      "name": nameController.text.trim(),
      "telephone": phoneController.text.trim(),
      "location": completeAddress.trim(),
      "password": passwordController.text.trim(),
      "image url": serviceProviderImageUrl,
      "status": "approved",
      "lat": position?.latitude,
      "long": position?.longitude,
    });

    //save data locally
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.setString("uid", user.uid);
    await sharedPreferences!.setString("email", user.email.toString());
    await sharedPreferences!.setString("name", nameController.text.trim());
    await sharedPreferences!
        .setString("telephone", phoneController.text.trim());
    await sharedPreferences!.setString("location", completeAddress.trim());
    await sharedPreferences!.setString("image url", serviceProviderImageUrl);

    CircularProgressIndicator(
      color: Colors.green,
    );
    Fluttertoast.showToast(msg: "Account created successfully :) ");
    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const AuthScreen()),
        (route) => false);
  }
}
