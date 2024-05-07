import 'package:flutter/material.dart';

class Styles {
  static List<String> categoryList = [
    'Business',
    'Programming',
    'It',
    'Hr',
    'Marketing',
    'Design',
    'Accounting'
  ];
  static List<String> jobsList = [
    'Manager',
    'Team Leader',
    'Designer',
    'Web designer',
    'Full Stack Developer',
    'Mobile Developer',
    'Marketing',
    'Digital Marketing'
  ];
  static const Color buttonColor = Color(0xffAC1457);
  static const Color scaffold =  Color.fromARGB(255, 204, 203, 203);
  static const Color darkBlue = Color.fromARGB(255, 50, 3, 181);
  static const TextStyle authenticationText30 =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white);
  static const TextStyle authenticationText15 =
      TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white);
  static const TextStyle listTitle =
      TextStyle(fontWeight: FontWeight.bold, color: Colors.black);
  static const TextStyle listTile =
      TextStyle(fontSize: 20, fontStyle: FontStyle.italic, color: Colors.black);
  static const TextStyle addTask = TextStyle(
      fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xffAC1457));
}
