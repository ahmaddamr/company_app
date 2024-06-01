import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/screens/tasks/widgets/tasks_widget.dart';
import 'package:shop_app/utils/styles.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});
  static String id = 'TasksScreen';

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  String? category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: const DrawerWidget(),
      appBar: AppBar(
        // leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return showCategory();
                },
              );
            },
            icon: const Icon(Icons.filter_list),
          )
        ],
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text(
          'Tasks',
          style: TextStyle(color: Styles.buttonColor),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('tasks')
            .where('taskCategory', isEqualTo: category)
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data != null && snapshot.data!.docs.isNotEmpty) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return TasksWidget(
                    title: snapshot.data!.docs[index]['taskTitle'],
                    subTitle: snapshot.data!.docs[index]['taskDerscreption'],
                    taskId: snapshot.data!.docs[index]['taskId'],
                    uploadedBy: snapshot.data!.docs[index]['uploadedBy'],
                    isDone: snapshot.data!.docs[index]['isDone'],
                  );
                },
              );
            } else {
              return const Center(child: Text('Tasks are Empty'));
            }
          }
          return const Center(child: Text('An Error Happened'));
        },
      ),
    );
  }

  Widget showCategory() {
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
                  onPressed: () {
                    setState(() {
                      category = Styles.categoryList[index];
                    });
                  },
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
            setState(() {
              category = null;
            });
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
            Navigator.pop(context);
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
// ListView.builder(
//         physics: const BouncingScrollPhysics(),
//         itemCount: 20,
//         itemBuilder: (context, index) {
//           return const TasksWidget();
//         },
//       ),
