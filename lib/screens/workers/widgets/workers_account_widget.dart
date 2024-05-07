import 'package:flutter/material.dart';
import 'package:shop_app/screens/auth/widgets/custom_button.dart';
import 'package:shop_app/utils/styles.dart';

class WorkersAccountWidget extends StatelessWidget {
  const WorkersAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Card(
              elevation: 5,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 45,
                      child: Image.network(
                        'https://cdn-icons-png.flaticon.com/128/3135/3135715.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Text(
                    'Mark Morph',
                    style: Styles.listTitle.copyWith(fontSize: 22),
                  ),
                  Text(
                    'Team Leader Since 2021-7-8',
                    style: Styles.listTitle
                        .copyWith(color: Styles.darkBlue, fontSize: 17),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Contact Info',
                            style: Styles.listTitle.copyWith(fontSize: 22),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Email: ',
                                    style: Styles.listTitle
                                        .copyWith(fontSize: 22)),
                                TextSpan(
                                  text: 'mark@gmail.com',
                                  style: Styles.authenticationText15.copyWith(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Phone Number: ',
                                  style:
                                      Styles.listTitle.copyWith(fontSize: 22),
                                ),
                                TextSpan(
                                  text: '5156116',
                                  style: Styles.authenticationText15.copyWith(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Image.network(
                            'https://cdn-icons-png.flaticon.com/128/4423/4423697.png',
                            width: 40,
                            height: 40,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Image.network(
                            'https://cdn-icons-png.flaticon.com/128/732/732200.png',
                            width: 40,
                            height: 40,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Image.network(
                            'https://cdn-icons-png.flaticon.com/128/152/152851.png',
                            width: 40,
                            height: 40,
                          ),
                        )
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 130, vertical: 30),
                    child: CustomButton(
                        text: 'Logout',
                        backgroundColor: Styles.buttonColor,
                        borderSideColor: Colors.transparent,
                        style: Styles.authenticationText15,
                        onPressed: () {}),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
