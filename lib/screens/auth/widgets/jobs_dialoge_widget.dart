import 'package:flutter/material.dart';
import 'package:shop_app/utils/styles.dart';

class JobsDialogeWidget extends StatelessWidget {
  const JobsDialogeWidget({super.key, this.onPressedText});

  final void Function()? onPressedText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Job Title',
        style: TextStyle(color: Styles.buttonColor),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.1,
        // height: MediaQuery.of(context).size.height * 0.4,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: Styles.jobsList.length,
          itemBuilder: (context, index) {
            return Row(
              
              children: [
                const Icon(
                  Icons.check_circle_rounded,
                  color: Colors.red,
                ),
                TextButton(
                  onPressed: onPressedText,
                  child: Text(
                    Styles.jobsList[index],
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
        )
      ],
    );
  }
}
