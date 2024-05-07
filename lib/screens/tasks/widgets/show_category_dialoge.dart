// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:shop_app/utils/styles.dart';

class ShowCategoryWidget extends StatelessWidget {
  const ShowCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Task Category',
        style: TextStyle(color: Styles.buttonColor),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.1,
        // height: MediaQuery.of(context).size.height * 0.4,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: Styles.categoryList.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                const Icon(
                  Icons.check_circle_rounded,
                  color: Colors.red,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    Styles.categoryList[index],
                    style: const TextStyle(fontSize: 18),
                  ),
                )
              ],
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Cancel',
            style: TextStyle(fontSize: 18),
          ),
        ),
        TextButton(
          onPressed: () {
            print('Apply Filter');
          },
          child: const Text(
            'Apply Filter',
            style: TextStyle(fontSize: 18),
          ),
        )
      ],
    );
  }
}
