// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, deprecated_member_use, avoid_print


import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inqueue/pages/homescreen.dart';
import 'package:slide_countdown/slide_countdown.dart';


class QrCodeViewerScreen extends StatefulWidget {
  static const routeName = "qr-code-screen";
  @override
  _QrCodeViewerScreenState createState() => _QrCodeViewerScreenState();
}

class _QrCodeViewerScreenState extends State<QrCodeViewerScreen> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("inQueue"),
          backwardsCompatibility: false,
        ),
        body: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Neumorphic(
                  margin: const EdgeInsets.only(
                      top: 5, left: 5, right: 5, bottom: 15),
                  style: NeumorphicStyle(
                      shape: NeumorphicShape.flat,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(12)),
                      depth: 8,
                      lightSource: LightSource.topLeft,
                      color: Colors.white),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'images/homeaffairs.png',
                          alignment: Alignment.center,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  "Home Affairs ",
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Center(
                                child: Text(
                                  "Station Road, Thaba Nchu Rural, Thaba Nchu",
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Row(children: [
                                  Icon(
                                    Icons.document_scanner,
                                    color: Colors.deepPurple,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "Identity Card (ID) or Document Application",
                                    style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                ]),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Center(
                                child: Text('#024',
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Center(
                                child: BarcodeWidget(
                                  barcode: Barcode.qrCode(),
                                  color: Colors.black,
                                  data: 'Counter 5',
                                  width: 200,
                                  height: 200,
                                ),
                              ),
                              SizedBox(height: 20),
                              Center(
                                child: Text(
                                  "Estimated Waiting Time",
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Center(
                                  child: SlideCountdownSeparated(
                                width: 40,
                                textStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Colors.green),
                                duration: const Duration(hours: 1, seconds: 1),
                              )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                RaisedButton(
                  padding: EdgeInsets.all(5),
                  elevation: 1,
                  color: Colors.black,
                  textColor: Colors.white,
                  child: SizedBox(
                    height: 40.0,
                    child: Center(
                      child: Text(
                        "CANCEL TICKET",
                        style:
                            TextStyle(fontSize: 18.0, fontFamily: "Brand Bold"),
                      ),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  onPressed: () {
                    showCupertinoDialog(
                        context: context, builder: createDialog);
                  },
                )
              ],
            ),
          ),
        ),
      );

  Widget createDialog(BuildContext context) => CupertinoAlertDialog(
        insetAnimationCurve: Curves.decelerate,
        title: Text(
          'Cancel Ticket',
          style: TextStyle(fontFamily: "Montserrat,"),
        ),
        content: Text("Are you sure you want to cancel the ticket?"),
        actions: [
          CupertinoDialogAction(
            child: Text("Yes"),
            onPressed: () {
              displayToastMsg();
              //redirect
              Navigator.pushNamedAndRemoveUntil(
                  context, Homescreen.routeName, (route) => false);
            },
          ),
          CupertinoDialogAction(
            child: Text("No"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );

  void displayToastMsg() =>
      Fluttertoast.showToast(msg: "Ticket cancelled successfully!",
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.transparent,
      fontSize: 15,
      textColor: Colors.black);
}
