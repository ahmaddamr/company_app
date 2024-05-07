import 'package:flutter/material.dart';
import 'package:shop_app/utils/styles.dart';

class TasksWidget extends StatelessWidget {
  const TasksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: ListTile(
        title: const Text(
          'title',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Styles.listTitle,
        ),
        onTap: () {},
        onLongPress: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 25,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Delete',
                          style: TextStyle(color: Colors.red, fontSize: 20),
                        ),
                      )
                    ],
                  )
                ],
              );
            },
          );
        },
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        leading: Container(
          padding: const EdgeInsets.only(right: 12),
          decoration: const BoxDecoration(
            border: Border(
              right: BorderSide(width: 1),
            ),
          ),
          child: CircleAvatar(
            radius: 20,
            child: Image.network(
                'https://cdn-icons-png.flaticon.com/128/5290/5290109.png'),
            // 'https://cdn-icons-png.flaticon.com/128/50/50037.png'
          ),
        ),
        subtitle: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.linear_scale,
              color: Styles.buttonColor,
            ),
            Text(
              'Subtitle/done',
              style: TextStyle(
                fontSize: 15,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        trailing: const Icon(
          Icons.keyboard_arrow_right,
          size: 30,
          color: Styles.buttonColor,
        ),
      ),
    );
  }
}
