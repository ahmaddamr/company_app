import 'package:flutter/material.dart';
import 'package:shop_app/screens/tasks/widgets/drawer_widget.dart';
import 'package:shop_app/screens/tasks/widgets/show_category_dialoge.dart';
import 'package:shop_app/screens/tasks/widgets/tasks_widget.dart';
import 'package:shop_app/utils/styles.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});
  static String id = 'TasksScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        // leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return const ShowCategoryWidget();
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
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 20,
        itemBuilder: (context, index) {
          return const TasksWidget();
        },
      ),
    );
  }
}
