import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/screens/auth/login/login_screen.dart';
import 'package:shop_app/screens/tasks/tasks_screen.dart';
import 'package:shop_app/utils/styles.dart';

class UserStateScreen extends StatelessWidget {
  const UserStateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const LoginScreen();
        } else if (snapshot.hasData) {
          return const TasksScreen() ;
        }else if (snapshot.hasError)
        {

          return Center(child: Text('An error Happened',style: Styles.authenticationText30.copyWith(color: Colors.black),));
        }
        else
        {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
