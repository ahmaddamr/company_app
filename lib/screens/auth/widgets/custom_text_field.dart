import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.hint,
      this.validator,
      this.onSaved,
      required this.obscureText,
      this.suffixIcon, this.controller, this.enabled});
  final String hint;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextEditingController? controller ;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      textInputAction: TextInputAction.next,
      style:const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
      controller: controller,
      obscureText: obscureText,
      onSaved: onSaved,
      validator: validator,
      decoration: InputDecoration(
        
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          suffixIcon: suffixIcon,
          constraints: const BoxConstraints(minWidth: 410, minHeight: 48),
          errorMaxLines: 1,
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white)
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(8.0),
          //   borderSide: const BorderSide(),
          // ),
          // enabledBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(8.0),
          //   borderSide: const BorderSide(
          //     color: Color.fromARGB(255, 249, 249, 249),
          //   ),
          // ),
          // focusedBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(8.0),
          //   borderSide: const BorderSide(
          //   ),
          // ),
          ),
    );
  }
}
