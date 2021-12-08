// ignore_for_file: sized_box_for_whitespace, unnecessary_import

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:inqueue/widgets/selectservices_page.dart';


class QueuesWidget extends StatelessWidget {
  const QueuesWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: InkWell(       
        onTap: (){
          Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context){
              return SelectServicesPage();
            }));},
        child: Neumorphic(
          margin: const EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 15),
          style: NeumorphicStyle(
            shape: NeumorphicShape.flat,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
            depth: 8,
            lightSource: LightSource.topLeft,
            color: Colors.white),
      
            child: Container(
              padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
      
                          children: const [
                            Text("ID Collection",
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black,
                            ),),
      
                            SizedBox(height: 5,),
                            Text("Lesego",
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12,
                                  color: Colors.green,
                                ),),
                          ],
                        ),
                    ),
                    
                  ],
                ),
              ),
        ),
      ),
    );
  }
}