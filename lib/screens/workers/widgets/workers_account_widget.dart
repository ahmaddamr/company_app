import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/screens/auth/widgets/custom_button.dart';
import 'package:shop_app/screens/auth/widgets/sign_errors_dialoge.dart';
import 'package:shop_app/screens/tasks/widgets/logout_alert_dialoge.dart';
import 'package:shop_app/utils/functions.dart';
import 'package:shop_app/utils/styles.dart';

// ignore: must_be_immutable
class WorkersAccountWidget extends StatefulWidget {
  const WorkersAccountWidget({super.key, required this.userId});
  final String userId;

  @override
  State<WorkersAccountWidget> createState() => _WorkersAccountWidgetState();
}

class _WorkersAccountWidgetState extends State<WorkersAccountWidget> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String name = '';

  String email = '';

  String? img;

  String position = '';

  String loggedAt = '';

  String? phoneNumber;
  @override
  void initState() {
    super.initState();
    getUserData();
  }
  //all done

  // function to show user data from firebase
  void getUserData() async {
    print('uid ${widget.userId}');
    try {
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .get();

      if (userDoc == null) {
        return;
      } else {
        email = await userDoc.get('email');
        name = await userDoc.get('name');
        position = await userDoc.get('position');
        img = await userDoc.get('userImage');
        phoneNumber = await userDoc.get('phoneNumber');
        Timestamp logged = await userDoc.get('createdAt');
        var joinedAt = logged.toDate();
        loggedAt = '${joinedAt.year}-${joinedAt.month}-${joinedAt.day}';
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Card(
              elevation: 5,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(img == null
                            ? 'https://cdn-icons-png.flaticon.com/128/3135/3135715.png'
                            : img!)),
                  ),
                  Text(
                    name,
                    style: Styles.listTitle.copyWith(fontSize: 22),
                  ),
                  Text(
                    'Account Created At: ${loggedAt}',
                    style: Styles.listTitle
                        .copyWith(color: Styles.darkBlue, fontSize: 17),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Contact Info',
                            style: Styles.listTitle.copyWith(fontSize: 22),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Email: ',
                                    style: Styles.listTitle
                                        .copyWith(fontSize: 22)),
                                TextSpan(
                                  text: email,
                                  style: Styles.authenticationText15.copyWith(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Phone Number: ',
                                  style:
                                      Styles.listTitle.copyWith(fontSize: 22),
                                ),
                                TextSpan(
                                  text: phoneNumber.toString(),
                                  style: Styles.authenticationText15.copyWith(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            Functions.openWhatsApp(
                                phoneNumber: phoneNumber.toString());
                          },
                          child: Image.network(
                            'https://cdn-icons-png.flaticon.com/128/4423/4423697.png',
                            width: 40,
                            height: 40,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Functions.openMail(email: email);
                          },
                          child: Image.network(
                            'https://cdn-icons-png.flaticon.com/128/732/732200.png',
                            width: 40,
                            height: 40,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Functions.openPhoneDialer(
                                phoneNumber: phoneNumber.toString());
                          },
                          child: Image.network(
                            'https://cdn-icons-png.flaticon.com/128/152/152851.png',
                            width: 40,
                            height: 40,
                          ),
                        )
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 120, vertical: 30),
                    child: CustomButton(
                        text: 'Logout',
                        backgroundColor: Styles.buttonColor,
                        borderSideColor: Colors.transparent,
                        style: Styles.authenticationText15,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return LogoutAlertDialoge();
                            },
                          );
                        }),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
