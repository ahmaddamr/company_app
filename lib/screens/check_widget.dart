import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/screens/auth/widgets/sign_errors_dialoge.dart';
import 'package:shop_app/utils/styles.dart';
import 'package:slide_to_act/slide_to_act.dart';

class CheckWidget extends StatefulWidget {
  const CheckWidget({super.key, required this.userId});
  final String userId;

  @override
  State<CheckWidget> createState() => _CheckWidgetState();
}

class _CheckWidgetState extends State<CheckWidget> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  String name = '';
  String checkIn = '--/--';
  String checkOut = '--/--';

  @override
  void initState() {
    super.initState();
    getUserData();
    getRecord();
  }

  void getRecord() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: widget.userId)
          .get();
      print(snap.docs[0].id);
      DocumentSnapshot snap2 = await FirebaseFirestore.instance
          .collection('users')
          .doc(snap.docs[0].id)
          .collection('Record')
          .doc(DateFormat('dd MMMM yyyy').format(
            DateTime.now(),
          ))
          .get();
      print(snap2['CheckIn']);
      setState(() {
        checkIn = snap2['CheckIn'];
        checkOut = snap2['checkOut'];
      });
    } catch (e) {
      setState(() {
        checkIn = '--/--';
        checkOut = '--/--';
      });
    }
  }

  void getUserData() async {
    print('uid $widget.uid}');
    try {
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .get();

      if (userDoc == null) {
        return;
      } else {
        name = await userDoc.get('name');
        setState(() {});
        User? user = auth.currentUser;
        String uid = user!.uid;
      }
    } catch (e) {
      SignErrorsDialoge(
        error: e.toString(),
      );
    }
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Welcome',
                  style: Styles.addTask,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  name,
                  style: Styles.listTile.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.045,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Todays Status',
                  style: Styles.listTile.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1,
                height: MediaQuery.of(context).size.height / 4.5,
                child: Card(
                  margin: const EdgeInsets.only(bottom: 20, top: 5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  elevation: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Check In',
                            style: Styles.addTask,
                          ),
                          Text(
                            checkIn,
                            style: Styles.listTile,
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Check Out',
                            style: Styles.addTask,
                          ),
                          Text(
                            checkOut,
                            style: Styles.listTile,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  DateTime.now().toString().substring(0, 11),
                  style: Styles.listTile.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              StreamBuilder(
                stream: Stream.periodic(
                  const Duration(seconds: 1),
                ),
                builder: (context, snapshot) {
                  return Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        DateFormat('hh:mm:ss a').format(
                          DateTime.now(),
                        ),
                        style: Styles.listTile),
                  );
                },
              ),
              checkOut == '--/--'
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Builder(
                        builder: (context) {
                          final GlobalKey<SlideActionState> key = GlobalKey();
                          return SlideAction(
                            text: checkIn == '--/--'
                                ? 'Slide To check In'
                                : 'Slide To check Out',
                            textColor: Colors.black,
                            outerColor: Colors.white,
                            innerColor: Styles.buttonColor,
                            key: key,
                            onSubmit: () async {
                              // Timer(const Duration(seconds: 1), () {
                              //   key.currentState!.reset();
                              // });
                              print(DateFormat('hh:mm').format(DateTime.now()));
                              QuerySnapshot snap = await FirebaseFirestore
                                  .instance
                                  .collection('users')
                                  .where('id', isEqualTo: widget.userId)
                                  .get();
                              print(snap.docs[0].id);
                              DocumentSnapshot snap2 =
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(snap.docs[0].id)
                                      .collection('Record')
                                      .doc(DateFormat('dd MMMM yyyy').format(
                                        DateTime.now(),
                                      ))
                                      .get();
                              try {
                                String checkIn = snap2['CheckIn'];
                                setState(() {
                                  checkOut = DateFormat('hh:mm a')
                                      .format(DateTime.now());
                                });
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(snap.docs[0].id)
                                    .collection('Record')
                                    .doc(DateFormat('dd MMMM yyyy').format(
                                      DateTime.now(),
                                    ))
                                    .update({
                                  'CheckIn': checkIn,
                                  'checkOut': DateFormat('hh:mm a')
                                      .format(DateTime.now())
                                });
                              } catch (e) {
                                setState(() {
                                  checkIn = DateFormat('hh:mm a')
                                      .format(DateTime.now());
                                });
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(snap.docs[0].id)
                                    .collection('Record')
                                    .doc(
                                      DateFormat('dd MMMM yyyy').format(
                                        DateTime.now(),
                                      ),
                                    )
                                    .set(
                                  {
                                    'CheckIn': DateFormat('hh:mm a')
                                        .format(DateTime.now()),
                                  },
                                );
                              }
                            },
                          );
                        },
                      ),
                    )
                  : const Center(
                      child: Text(
                        'The Day Has Ended',
                        style: Styles.addTask,
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
