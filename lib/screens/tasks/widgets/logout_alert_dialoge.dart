import 'package:flutter/material.dart';
import 'package:shop_app/utils/styles.dart';

class LogoutAlertDialoge extends StatelessWidget {
  const LogoutAlertDialoge({super.key});

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
            child: Text('Sign out'),
          )
        ],
      ),
      content: const Text(
        'Do you want to Sign out?',
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
          onPressed: () {},
          child: const Text(
            'Ok',
            style: TextStyle(fontSize: 15, color: Colors.red),
          ),
        )
      ],
    );
  }
}
