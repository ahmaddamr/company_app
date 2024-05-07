import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/utils/styles.dart';

class RichTextWidget extends StatelessWidget {
  const RichTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          const TextSpan(
              text: 'Already have an account?  ',
              style: Styles.authenticationText15),
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.of(context).pushReplacementNamed('LoginScreen');
              },
            text: 'Login',
            style: Styles.authenticationText15.copyWith(
                color: Colors.blue, decoration: TextDecoration.underline),
          ),
        ],
      ),
    );
  }
}
