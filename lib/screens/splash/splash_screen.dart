import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/screens/auth/login/login_screen.dart';
import 'package:shop_app/screens/tasks/tasks_screen.dart';
import 'package:shop_app/utils/styles.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({super.key});

  @override
  State<SpalshScreen> createState() => _SpalshPageState();
}

class _SpalshPageState extends State<SpalshScreen> {
  Timer? _timer;
  _startDelay() {
    _timer = Timer(Duration(seconds: 2), _goNext);
  }

  _goNext() {
    FirebaseAuth.instance.currentUser != null
        ? Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const TasksScreen()))
        : Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  initState() {
    _startDelay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Image.network(
                  'https://cdn-icons-png.flaticon.com/128/993/993854.png')),
          Center(
              child: Text(
            'Company App',
            style: Styles.authenticationText30.copyWith(color: Styles.darkBlue),
          )),
        ],
      ),
    );
  }
}
