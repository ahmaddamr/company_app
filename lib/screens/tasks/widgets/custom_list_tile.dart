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
    return ListTile(
      onTap: onTap,
      title: Text(
        text,
        style: Styles.listTile,
      ),
      leading: leading,
    );
  }
}
