import 'dart:async';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/firebase_options.dart';
import 'package:shop_app/screens/auth/login/forget_password_screen.dart';
import 'package:shop_app/screens/auth/login/login_screen.dart';
import 'package:shop_app/screens/auth/signup/signup_screen.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'package:shop_app/screens/tasks/add_task_screen.dart';
import 'package:shop_app/screens/tasks/task_details_screen.dart';
import 'package:shop_app/screens/tasks/tasks_screen.dart';
import 'package:shop_app/screens/user_state_screen.dart';
import 'package:shop_app/screens/workers/worker_account_screen.dart';
import 'package:shop_app/screens/workers/workers_screen.dart';
import 'package:shop_app/utils/styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const CompanyApp());
}

class CompanyApp extends StatelessWidget {
  const CompanyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        'LoginScreen': (context) => const LoginScreen(),
        'SignUpScreen': (context) => const SignUpScreen(),
        'ForgetPasswordScreen': (context) => const ForgetPasswordScreen(),
        'TasksScreen': (context) => const TasksScreen(),
        'AddTaskScreen': (context) => const AddTaskScreen(),
        'WorkersScreen': (context) => const WorkersScreen(),
        'WorkerAccountScreen': (context) => const WorkerAccountScreen(),
        'TaskDetailsScreen': (context) => TaskDetailsScreen(),
        'UserStateScreen': (context) => const UserStateScreen(),
        'SpalshScreen':(context) => const SpalshScreen()
      },
      initialRoute: 'SpalshScreen', //bad
      theme: ThemeData(
        scaffoldBackgroundColor: Styles.scaffold,
      ),
    );
  }
}

