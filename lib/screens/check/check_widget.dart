import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/screens/auth/widgets/sign_errors_dialoge.dart';
import 'package:shop_app/services/user_class.dart';
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
  String day = '';
  String checkIn = '--/--';
  String checkOut = '--/--';
  String location = '';

  @override
  void initState() {
    super.initState();
    getUserData();
    getRecord();
    getLocation();
  }

  void getLocation() async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(UserClass.lat, UserClass.long);
    setState(() {
      location =
          '${placemark[0].street},${placemark[0].administrativeArea},${placemark[0].postalCode},${placemark[0].country}';
          print(placemark);
    });
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
        day = await userDoc.get('createdAt');
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
                              if (UserClass.lat != 0) {
                                getLocation();
                                Timer(const Duration(milliseconds: 500), () {
                                  key.currentState!.reset();
                                });
                                print(
                                    DateFormat('hh:mm').format(DateTime.now()));
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
                                        .format(DateTime.now()),
                                    'date': Timestamp.now(),
                                    'location': location
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
                                      'checkOut': '--/--',
                                      'date': Timestamp.now(),
                                      'loaction': location
                                    },
                                  );
                                  key.currentState!.reset();
                                }
                              } else {
                                Timer(Duration(seconds: 3), () async {
                                  getLocation();
                                  Timer(const Duration(milliseconds: 500), () {
                                    key.currentState!.reset();
                                  });
                                  print(DateFormat('hh:mm')
                                      .format(DateTime.now()));
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
                                          .doc(
                                              DateFormat('dd MMMM yyyy').format(
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
                                          .format(DateTime.now()),
                                      'date': Timestamp.now(),
                                      'location': location
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
                                        'checkOut': '--/--',
                                        'date': Timestamp.now(),
                                        'loaction': location
                                      },
                                    );
                                    key.currentState!.reset();
                                  }
                                });
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
                    ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.035,
              ),
              location != '' ? Text(
                'Location: ' + location,
                style: Styles.listTile,
              ): const SizedBox(),
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'My Attendance:',
                  style: Styles.addTask,
                ),
              ),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        DateFormat('MMMM').format(DateTime.now()),
                        style: Styles.listTile,
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(right: 25.0),
                  //   child: Container(
                  //     alignment: Alignment.centerRight,
                  //     child: const Text(
                  //       'Pick a Month',
                  //       style: Styles.listTile,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.userId)
                    .collection('Record')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    final snap = snapshot.data!.docs;
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snap.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: MediaQuery.of(context).size.width / 4.5,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 1,
                            height: MediaQuery.of(context).size.width / 4.5,
                            child: Card(
                              margin: const EdgeInsets.only(top: 5),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              elevation: 10,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Flexible(
                                    fit: FlexFit.tight,
                                    child: Container(
                                      height: 150,
                                      // width: 10,
                                      decoration: const BoxDecoration(
                                        color: Styles.buttonColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            snap[index].id,
                                            style: Styles.addTask.copyWith(
                                                color: Colors.white,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 60.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Check In',
                                          style: Styles.addTask,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            snap[index]['CheckIn'],
                                            style: Styles.listTile,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 50.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Check Out',
                                          style: Styles.addTask,
                                        ),
                                        Text(
                                          snap[index]['checkOut'],
                                          style: Styles.listTile,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
