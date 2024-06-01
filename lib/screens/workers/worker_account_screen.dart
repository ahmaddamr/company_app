import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/screens/workers/widgets/workers_account_widget.dart';

class WorkerAccountScreen extends StatelessWidget {
  const WorkerAccountScreen({super.key});
  static String id = 'WorkerAccountScreen';

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      // drawer: const DrawerWidget(),
      body:  WorkersAccountWidget(userId:uid ,),
    );
  }
}
