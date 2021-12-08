// ignore_for_file: sized_box_for_whitespace, deprecated_member_use, non_constant_identifier_names, prefer_const_literals_to_create_immutables, unused_import

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:inqueue/global/global.dart';
import 'package:inqueue/widgets/queueswidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'addnewservice.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp();

  runApp(const Homescreen());
}

class Homescreen extends StatelessWidget {
  static const String routeName = "home";

  const Homescreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              margin: EdgeInsets.only(bottom: 50),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle, color: Colors.green),
              child: Text("name",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const ListTile(
                selectedTileColor: Colors.lightGreen,
                leading: Icon(
                  Icons.person,
                  color: Colors.green,
                ),
                title: Text(
                  'Profile',
                  style: TextStyle(
                      color: Colors.green,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold),
                )),
            const SizedBox(height: 5),
            const ListTile(
              selectedTileColor: Colors.lightGreen,
              leading: Icon(
                Icons.receipt_long,
                color: Colors.green,
              ),
              title: Text('Queues',
                  style: TextStyle(
                      color: Colors.green,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 5),
            const ListTile(
                selectedTileColor: Colors.lightGreen,
                leading: Icon(
                  Icons.settings,
                  color: Colors.green,
                ),
                title: Text('Settings',
                    style: TextStyle(
                        color: Colors.green,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold))),
            const ListTile(),
            ListTile(
                onTap: () {
                  Navigator.pop(context);
                },
                selectedTileColor: Colors.lightGreen,
                leading: const Icon(
                  Icons.logout_outlined,
                  color: Colors.green,
                ),
                title: const Text('Logout',
                    style: TextStyle(
                        color: Colors.green,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold))),
          ],
        ),
      ),
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          "inQueue",
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Queues",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Montserrat",
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
          QueuesWidget(),
          QueuesWidget(),
          QueuesWidget(),
          QueuesWidget(),
          QueuesWidget(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: (){
           Navigator.pushNamed(context, AddNewService.routeName);

        },
        child: const Icon(Icons.add,
        color: Colors.white,),
      ),
    );
    
  }

  Widget QueuesWidget() {
    return Neumorphic(
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "ID Collection",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "10988 Cnr. George Lubbe & Moshoeshoe Street, Rocklands",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
