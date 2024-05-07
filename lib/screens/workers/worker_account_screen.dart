import 'package:flutter/material.dart';
import 'package:shop_app/screens/tasks/widgets/drawer_widget.dart';
import 'package:shop_app/screens/workers/widgets/workers_account_widget.dart';

class WorkerAccountScreen extends StatelessWidget {
  const WorkerAccountScreen({super.key});
  static String id = 'WorkerAccountScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      drawer: const DrawerWidget(),
      body: const WorkersAccountWidget(),
    );
  }
}
