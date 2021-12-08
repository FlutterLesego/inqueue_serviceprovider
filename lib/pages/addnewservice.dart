// ignore_for_file: avoid_unnecessary_containers, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class AddNewService extends StatefulWidget {
  const AddNewService({ Key? key }) : super(key: key);
    static const String routeName = "add new service";


  @override
  _AddNewServiceState createState() => _AddNewServiceState();
}

class _AddNewServiceState extends State<AddNewService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text("Add a new service",
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            color: Colors.black),),
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
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
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
                    padding: const EdgeInsets.only(
                        top: 20, left: 20.0, right: 20.0),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
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
                    const SizedBox(height: 100,),
                    Center(
                      
                      child: RaisedButton( 
                        color: Colors.green,
                        child: const Text("Save",
                        style: TextStyle(color: Colors.white),),
                        onPressed: (){}),
                    )
              ],
            ),
          ),
        ));
  }
}