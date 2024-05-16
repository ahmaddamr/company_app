import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/screens/tasks/task_details_screen.dart';
import 'package:shop_app/utils/styles.dart';

class TasksWidget extends StatelessWidget {
  const TasksWidget(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.taskId,
      required this.uploadedBy,
      required this.isDone});
  final String title;
  final String subTitle;
  final String taskId;
  final String uploadedBy;
  final bool isDone;

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: ListTile(
        title: Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Styles.listTitle,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskDetailsScreen(
                taskId: taskId,
                uploadedBy: uploadedBy,
              ),
            ),
          );
        },
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
                        onPressed: () {
                          User? user = auth.currentUser;
                          String uid = user!.uid;
                          if (uid == uploadedBy) {
                            FirebaseFirestore.instance
                                .collection('tasks')
                                .doc(taskId)
                                .delete();
                            Navigator.pop(context);
                          } else {
                            (
                              Fluttertoast.showToast(
                                  msg:
                                      "You dont Have access to Delete This Task",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 18.0),
                            );
                          }
                        },
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
              child: Image.network(isDone
                  ? 'https://cdn-icons-png.flaticon.com/128/5290/5290109.png'
                  : 'https://cdn-icons-png.flaticon.com/128/50/50037.png')),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.linear_scale,
              color: Styles.buttonColor,
            ),
            Text(
              subTitle,
              style: const TextStyle(
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
