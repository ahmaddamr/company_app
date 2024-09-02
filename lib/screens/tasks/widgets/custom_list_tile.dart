import 'package:flutter/material.dart';
import 'package:shop_app/utils/styles.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {super.key, required this.text, this.leading, this.onTap});
  final String text;
  final Widget? leading;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ListTile(
          onTap: onTap,
          title: Text(
            text,
            style: Styles.listTile,
          ),
          leading: leading,
        ),
        // Padding(
        //   padding: const EdgeInsets.all(15.0),
        //   child: CustomButton(
        //       text: 'Subscribe',
        //       backgroundColor: Styles.buttonColor,
        //       borderSideColor: Colors.transparent,
        //       style: Styles.authenticationText15,
        //       onPressed: () 
        //       async{
        //       await  FirebaseMessaging.instance.subscribeToTopic('ahmed');
        //         print('subscribed');
        //       }),
        // )
      ],
    );
  }
}
