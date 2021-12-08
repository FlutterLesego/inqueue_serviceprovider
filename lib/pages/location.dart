// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sized_box_for_whitespace, camel_case_types

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPage extends StatelessWidget {
  static const String routeName = '/location';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => LocationPage(),
      settings: RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: GoogleMap(
            mapType: MapType.satellite,
            initialCameraPosition:
                CameraPosition(target: LatLng(10, 10), zoom: 10),
          ),
        ),
        Positioned(top: 50, left: 20, right: 20, child: locationsearchbox()),
        // Positioned(
        //   top: 50, left: 20, right: 20,
        // child: ElevatedButton(
        //     style: ElevatedButton.styleFrom(
        //       primary: Theme.of(context).primaryColor),
        //       child: Text('Save Location'),
        //     onPressed: (){},
        //     ),),
      ],
    ));
  }
}

class locationsearchbox extends StatelessWidget {
  const locationsearchbox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
          decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: 'Enter your location',
        suffixIcon: Icon(
          Icons.search,
          color: Colors.green,
        ),
        contentPadding: EdgeInsets.only(left: 20, top: 20, right: 20),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white),
        ),
      )),
    );
  }
}
