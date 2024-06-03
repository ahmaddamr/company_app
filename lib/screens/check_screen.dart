import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/screens/check_widget.dart';

class CheckScreen extends StatelessWidget {
  const CheckScreen({super.key});

  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    return Scaffold(
        body: CheckWidget(
      userId: uid,
    ));
  }
}
