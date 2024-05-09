import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/firebase_options.dart';
import 'package:shop_app/screens/auth/login/forget_password_screen.dart';
import 'package:shop_app/screens/auth/login/login_screen.dart';
import 'package:shop_app/screens/auth/signup/signup_screen.dart';
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
        'UserStateScreen':(context) =>const UserStateScreen()
      },
      initialRoute: 'SignUpScreen',
      theme: ThemeData(
        scaffoldBackgroundColor: Styles.scaffold,
      ),
    );
    // FutureBuilder(
    //   future: initializeApp,
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const MaterialApp(
    //         debugShowCheckedModeBanner: false,
    //         home: Scaffold(
    //           body: Center(
    //             child: CircularProgressIndicator(),
    //           ),
    //         ),
    //       );
    //     } else if (snapshot.hasError) {
    //       return MaterialApp(
    //         debugShowCheckedModeBanner: false,
    //         home: Scaffold(
    //           body: Center(
    //             child: Text(
    //               'Error In Firebase',
    //               style:
    //                   Styles.authenticationText30.copyWith(color: Colors.black),
    //             ),
    //           ),
    //         ),
    //       );
    //     } else {
    //       return MaterialApp(
    //         debugShowCheckedModeBanner: false,
    //         routes: {
    //           'LoginScreen': (context) => const LoginScreen(),
    //           'SignUpScreen': (context) => const SignUpScreen(),
    //           'ForgetPasswordScreen': (context) => const ForgetPasswordScreen(),
    //           'TasksScreen': (context) => const TasksScreen(),
    //           'AddTaskScreen': (context) => const AddTaskScreen(),
    //           'WorkersScreen': (context) => const WorkersScreen(),
    //           'WorkerAccountScreen': (context) => const WorkerAccountScreen(),
    //           'TaskDetailsScreen': (context) => TaskDetailsScreen()
    //         },
    //         initialRoute: 'SignUpScreen',
    //         theme: ThemeData(
    //           scaffoldBackgroundColor: Styles.scaffold,
    //         ),
    //       );
    //     }
    //   },
    // );
  }
}
// MaterialApp(
//       debugShowCheckedModeBanner: false,
//       routes: {
//         'LoginScreen': (context) => const LoginScreen(),
//         'SignUpScreen': (context) => const SignUpScreen(),
//         'ForgetPasswordScreen': (context) => const ForgetPasswordScreen(),
//         'TasksScreen': (context) => const TasksScreen(),
//         'AddTaskScreen': (context) => const AddTaskScreen(),
//         'WorkersScreen': (context) => const WorkersScreen(),
//         'WorkerAccountScreen': (context) => const WorkerAccountScreen(),
//         'TaskDetailsScreen': (context) => TaskDetailsScreen()
//       },
//       initialRoute: 'SignUpScreen',
//       theme: ThemeData(
//         scaffoldBackgroundColor: Styles.scaffold,
//       ),
//     );
