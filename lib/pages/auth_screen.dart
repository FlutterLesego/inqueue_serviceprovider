import 'package:flutter/material.dart';
import 'package:inqueue/pages/login.dart';
import 'package:inqueue/pages/signup.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);
    static const String routeName = "authscreen";


  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text (
            "inQueue",
            style: TextStyle(
              fontSize: 35,
              color: Colors.black,
              fontFamily: 'Montserrat-Bold',
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                text: ("Login"),
              ),
              Tab(
                text: "Register",
              )
            ],
            indicatorColor: Colors.green,
            labelColor: Colors.green,
            indicatorWeight: 2,),
          ),
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white),
            child: const TabBarView(
              children: [
                LoginPage(), 
                Signup()],),
        ),
        ),
      );
  }
}
