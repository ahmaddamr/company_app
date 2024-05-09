import 'package:flutter/material.dart';
import 'package:shop_app/utils/styles.dart';

class SignErrorsDialoge extends StatelessWidget {
  const SignErrorsDialoge({super.key, required this.error});
  final String error;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Image.network(
            'https://cdn-icons-png.flaticon.com/128/14090/14090276.png',
            height: 25,
            width: 25,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Error'),
          )
        ],
      ),
      content: Text(
        error,
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
      ],
    );
  }
}
