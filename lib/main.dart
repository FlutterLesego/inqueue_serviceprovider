import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:inqueue/pages/addnewservice.dart';
import 'package:inqueue/pages/auth_screen.dart';
import 'package:inqueue/pages/homescreen.dart';
import 'package:inqueue/pages/login.dart';
import 'package:inqueue/pages/signup.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//import 'package:inqueue/verification/startpage.dart';
//import 'package:inqueue/pages/login.dart';
//import 'package:phoneverification/splash/splash.dart';
import 'package:page_transition/page_transition.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    home: MyApp(),
  ));
}

DatabaseReference usersRef =
    FirebaseDatabase.instance.reference().child("service providers");

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            const MaterialApp(
              home: Scaffold(
                body: Center(child: Text('Error occured!')),
              ),
            );
          }
          return MaterialApp(
              initialRoute: (FirebaseAuth.instance.currentUser == null)
                  ? LoginPage.routeName
                  : Homescreen.routeName,
              routes: {
                Signup.routeName: (context) => const Signup(),
                Homescreen.routeName: (context) => const Homescreen(),
                LoginPage.routeName: (context) => const LoginPage(),
                AuthScreen.routeName: (context) => const AuthScreen(),
                AddNewService.routeName: (context) => const AddNewService(),
              },
              debugShowCheckedModeBanner: false,
              home: AnimatedSplashScreen(
                duration: 3000,
                splash: 'assets/images/logo.png',
                nextScreen: const AuthScreen(),
                centered: true,
                animationDuration: const Duration(seconds: 2),
                splashTransition: SplashTransition.fadeTransition,
                pageTransitionType: PageTransitionType.topToBottom,
                backgroundColor: Colors.white,
              ));
        });
  }
}
