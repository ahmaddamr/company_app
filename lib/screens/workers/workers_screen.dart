import 'package:flutter/material.dart';
import 'package:shop_app/screens/tasks/widgets/drawer_widget.dart';
import 'package:shop_app/screens/workers/workers_widget.dart';
import 'package:shop_app/utils/styles.dart';

class WorkersScreen extends StatelessWidget {
  const WorkersScreen({super.key});
  static String id = 'WorkersScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text(
          'All Workers',
          style: TextStyle(color: Styles.buttonColor),
        ),
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 20,
        itemBuilder: (context, index) {
          return const WorkersWidget();
        },
      ),
    );
  }
}
