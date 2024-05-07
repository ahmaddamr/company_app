import 'package:flutter/material.dart';
import 'package:shop_app/screens/tasks/widgets/custom_list_tile.dart';
import 'package:shop_app/screens/tasks/widgets/logout_alert_dialoge.dart';
import 'package:shop_app/utils/styles.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 40),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.26,
            decoration: const BoxDecoration(
              color: Color(0xff00BBD2),
            ),
            child: Column(
              children: [
                Image.network(
                  'https://cdn-icons-png.flaticon.com/128/4472/4472515.png',
                  width: 60,
                  height: 60,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.020,
                ),
                Text(
                  'Work OS',
                  style: Styles.authenticationText30.copyWith(
                      color: Colors.black, fontStyle: FontStyle.italic),
                )
              ],
            ),
          ),
          CustomListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('TasksScreen');
            },
            text: 'All Tasks',
            leading: const Icon(Icons.task),
          ),
          CustomListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('WorkerAccountScreen');
            },
            text: 'My Account',
            leading: const Icon(Icons.settings),
          ),
          CustomListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('WorkersScreen');
            },
            text: 'Registered Workers',
            leading: const Icon(Icons.workspace_premium),
          ),
          CustomListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('AddTaskScreen');
            },
            text: 'Add task',
            leading: const Icon(Icons.add_task),
          ),
          const Divider(
            thickness: 1,
          ),
          CustomListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return const LogoutAlertDialoge();
                },
              );
            },
            text: 'Logout',
            leading: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
    );
  }
}
