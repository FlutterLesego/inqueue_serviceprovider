// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

class ServicesWidget extends StatelessWidget {
  const ServicesWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
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
                        Text("Services Available:",
                        style: TextStyle(
                          color: Colors.green,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),),
                        //Icon(Icons.home_repair_service_rounded, color: Colors.green,)
                      ],
                    ),
                    const SizedBox(height: 5.0),
                    const Text("Select a Service to Continue", 
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.black
                    ),),
                    const Divider(
                      color: Colors.black,
                    ),
                    
                    ListTile(
                      onTap: ()
                      {
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(builder: (BuildContext context){
                        //   return RequirementsScreens();
                        
                      },
                      title: const Text('ID Collection'),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded, 
                      color: Colors.green,
                    ),),
                    
                  ],
                  ),
                  
                ),
                
              ),
            ),
            
          )
        ],
      ),
    );
  }
}