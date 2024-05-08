import 'package:url_launcher/url_launcher.dart';

class Functions {
  static void openWhatsApp() async {
    // Replace '+XX XXXX XXXX' with the phone number with your country code and without any spaces
    // Replace 'Message...' with the message you want to send.
    String phoneNumber = '01288226896';
    String url = 'https://wa.me/$phoneNumber/?text=${Uri.parse('Message...')}';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static void openMail() async {
    String email = 'ahmed.eslam51a@@gmail.com';
    String url = 'mailto:$email';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  static void openPhoneDialer() async {
    String phoneNumber = '01288226896';
    String url = 'tel:$phoneNumber';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
