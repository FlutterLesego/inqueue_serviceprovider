// ignore_for_file: use_key_in_widget_constructors, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class SelectServicesPage extends StatefulWidget {
  @override
  _SelectServicesPageState createState() => _SelectServicesPageState();
}

class _SelectServicesPageState extends State<SelectServicesPage> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ServicesWidget(screenHeight: screenHeight)
        ],
      ),
    );
  }
}

class ServicesWidget extends StatelessWidget {
  const ServicesWidget({
    Key? key,
    required this.screenHeight,
  }) : super(key: key);

  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        margin: EdgeInsets.only(top: screenHeight*0.3),
        child: Material(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50.0), topRight: Radius.circular(50.0)),
          child: Container(
            padding: const EdgeInsets.only(left: 30, top: 30, right: 15, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text("ID Collection",
                  style: TextStyle(
                    color: Colors.green,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),),
                  //Icon(Icons.home_repair_service_rounded, color: Colors.green,)
                ],
              ),      
            ],
            ),
            
          ),
          
        ),
      ),
      
    );
    
  }
}
