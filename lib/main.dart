import 'package:flutter/material.dart';
import 'package:shop_app/screens/auth/login/forget_password_screen.dart';
import 'package:shop_app/screens/auth/login/login_screen.dart';
import 'package:shop_app/screens/auth/signup/signup_screen.dart';
import 'package:shop_app/screens/tasks/add_task_screen.dart';
import 'package:shop_app/screens/tasks/task_details_screen.dart';
import 'package:shop_app/screens/tasks/tasks_screen.dart';
import 'package:shop_app/screens/workers/worker_account_screen.dart';
import 'package:shop_app/screens/workers/workers_screen.dart';
import 'package:shop_app/utils/styles.dart';

void main() {
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
        'TasksScreen': (context) =>const TasksScreen(),
        'AddTaskScreen': (context) =>const AddTaskScreen(),
        'WorkersScreen': (context) => const WorkersScreen(),
        'WorkerAccountScreen': (context) => const WorkerAccountScreen(),
        'TaskDetailsScreen':(context) => TaskDetailsScreen()
      },
      initialRoute: 'SignUpScreen',
      theme: ThemeData(
        scaffoldBackgroundColor: Styles.scaffold,
      ),
      // home: const LoginScreen(),
    );
  }
}
