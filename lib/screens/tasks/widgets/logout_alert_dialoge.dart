import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/utils/styles.dart';

class LogoutAlertDialoge extends StatelessWidget {
  LogoutAlertDialoge({super.key});
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Image.network(
            'https://cdn-icons-png.flaticon.com/128/1828/1828490.png',
            height: 25,
            width: 25,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Logout'),
          )
        ],
      ),
      content: const Text(
        'Do you want to Logout?',
        style: Styles.listTile,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Cancel',
            style: TextStyle(fontSize: 15),
          ),
        ),
        TextButton(
          onPressed: () async {
            await auth.signOut();
            Navigator.of(context).pushReplacementNamed('SignUpScreen');
          },
          child: const Text(
            'Ok',
            style: TextStyle(fontSize: 15, color: Colors.red),
          ),
        )
      ],
    );
  }
}
