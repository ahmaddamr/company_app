import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Functions {
  static void openWhatsApp({required String phoneNumber}) async {
    // Replace '+XX XXXX XXXX' with the phone number with your country code and without any spaces
    // Replace 'Message...' with the message you want to send.
    // String phoneNumber = '01288226896';
    String url = 'https://wa.me/$phoneNumber/?text=${Uri.parse('Message...')}';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static void openMail({required String email}) async {
    // String email = 'ahmed.eslam51a@@gmail.com';
    String mailUrl = 'mailto:$email';
    try {
      await launchUrlString(mailUrl);
    } catch (e) {
      await Clipboard.setData(
        ClipboardData(text: email),
      );
    }
  }

  static void openPhoneDialer({required String phoneNumber}) async {
    // String phoneNumber = '01288226896';
    String url = 'tel:$phoneNumber';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
