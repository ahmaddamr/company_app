import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/screens/workers/workers_widget.dart';
import 'package:shop_app/utils/styles.dart';

class WorkersScreen extends StatelessWidget {
  WorkersScreen({super.key});
  static String id = 'WorkersScreen';

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        // drawer: const DrawerWidget(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: const Text(
            'All Workers',
            style: TextStyle(color: Styles.buttonColor),
          ),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.data!.docs.isNotEmpty) {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return WorkersWidget(
                      email: snapshot.data!.docs[index]['email'],
                      uid: snapshot.data!.docs[index]['id'],
                      name: snapshot.data!.docs[index]['name'],
                      img: snapshot.data!.docs[index]['userImage'],
                      position: snapshot.data!.docs[index]['position'],
                    );
                  },
                );
              } else {
                return const Center(child: Text('no tasks has been uploaded'));
              }
            }
            return const Center(child: Text('something went wrong'));
          },
        ));
  }
}
//  ListView.builder(
//         physics: const BouncingScrollPhysics(),
//         itemCount: 20,
//         itemBuilder: (context, index) {
//           return const WorkersWidget();
//         },
//       ),
