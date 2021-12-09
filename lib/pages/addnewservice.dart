// ignore_for_file: avoid_unnecessary_containers, deprecated_member_use, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inqueue/global/global.dart';
import 'package:inqueue/models/services_model.dart';
import 'package:inqueue/pages/homescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddNewService extends StatefulWidget {
  const AddNewService({Key? key}) : super(key: key);
  static const String routeName = "add new service";

  @override
  _AddNewServiceState createState() => _AddNewServiceState();
}

var titleController = TextEditingController(text: "");
var requirementsController = TextEditingController(text: "");

class _AddNewServiceState extends State<AddNewService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text(
            "Add a new service",
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
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
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: titleController,
                          autovalidateMode: AutovalidateMode.always,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Title of the service required';
                            } else {
                              return null;
                            }
                          },
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                              labelText: 'TITLE',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green))),
                        ),
                      ],
                    )),
                const SizedBox(height: 20),
                Container(
                    padding:
                        const EdgeInsets.only(top: 20, left: 20.0, right: 20.0),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: requirementsController,
                          minLines: 2,
                          maxLines: 10,
                          autovalidateMode: AutovalidateMode.always,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Service requirements required';
                            } else {
                              return null;
                            }
                          },
                          textInputAction: TextInputAction.newline,
                          keyboardType: TextInputType.multiline,
                          decoration: const InputDecoration(
                              labelText: 'REQUIREMENTS',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green))),
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 100,
                ),
                
                Center(
                  child: RaisedButton(
                      color: Colors.green,
                      child: const Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        postDetailsToFirestore();
                      }),
                )
              ],
            ),
          ),
        ));
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = firebaseAuth.currentUser;

    ServicesModel servicesModel = ServicesModel();

    // writing all the values
    servicesModel.title = titleController.text.trim();
    servicesModel.requirements = requirementsController.text.trim();
    //servicesModel.serviceTime = nameController.text.trim();
    

    await firebaseFirestore
        .collection("services")
        .doc(servicesModel.title)
        .set({
      "Title": titleController.text.trim(),
      "Requirements": requirementsController.text.trim(),
      //"Service Time": serv.text.trim(),
    });

    //save data locally
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.setString("Title", titleController.text.trim());
    await sharedPreferences!.setString("Requirements", requirementsController.text.trim());
    //sharedPreferences!.setString("Service Time", nameController.text.trim());

    const CircularProgressIndicator(
      color: Colors.green,
    );
    Fluttertoast.showToast(msg: "Service added successfully :)");
    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const Homescreen()),
        (route) => false);
  }
}
