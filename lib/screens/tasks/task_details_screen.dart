import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/screens/auth/widgets/custom_button.dart';
import 'package:shop_app/utils/styles.dart';

class TaskDetailsScreen extends StatefulWidget {
  //dependecy injection
  final String taskId;
  final String uploadedBy;

  const TaskDetailsScreen(
      {super.key, required this.taskId, required this.uploadedBy});
  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  // const TaskDetailsScreen({super.key});
  late TextEditingController _descriptionController =
      TextEditingController(text: '');

  bool isCommenting = false;
  String? authorName;
  String? authorPosition;
  String? taskDerscreption;
  String? taskTitle;
  String? imageUrl;
  bool? isDone;
  bool isDeadlineAvailable = false;
  Timestamp? postedAtTimestamp;
  Timestamp? deadlineDateTimestamp;
  String? deadlineDate;
  String? postedAt;
  final FirebaseAuth auth = FirebaseAuth.instance ;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uploadedBy)
        .get();
    if (userDoc == null) {
      return;
    } else {
      setState(() {
        authorName = userDoc.get('name');
        authorPosition = userDoc.get('position');
        imageUrl = userDoc.get('userImage');
      });
    }
    final DocumentSnapshot taskDatabase = await FirebaseFirestore.instance
        .collection('tasks')
        .doc(widget.taskId)
        .get();
    if (taskDatabase == null) {
      return;
    } else {
      print('test1');
      taskDerscreption = taskDatabase.get('taskDerscreption');
      isDone = await taskDatabase.get('isDone');
      deadlineDate = await taskDatabase.get('deadlineDate');
      deadlineDateTimestamp = await taskDatabase.get('deadlineDateTimestamp');
      postedAtTimestamp = await taskDatabase.get('createdAt');
      var postDate = postedAtTimestamp!.toDate();
      postedAt = '${postDate.year}-${postDate.month}-${postDate.day}';
      var date = deadlineDate;
      var isDeadlineAvailable = date;
      // postedAt = '${postDate.year}-${postDate.month}-${postDate.day}';
      print('test2');
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      // drawer: const DrawerWidget(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              taskTitle ?? '',
              style:
                  Styles.authenticationText30.copyWith(color: Styles.darkBlue),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Card(
                elevation: 5,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'uploaded by',
                            style: Styles.listTitle
                                .copyWith(color: Styles.darkBlue, fontSize: 17),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .2,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(imageUrl == null
                                ? 'https://cdn-icons-png.flaticon.com/128/3135/3135715.png'
                                : imageUrl!),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              authorName ?? '',
                              overflow: TextOverflow.clip,
                              style: Styles.listTitle.copyWith(
                                  fontSize: 16, fontStyle: FontStyle.italic),
                            ),
                            Text(
                              authorPosition == null ? '' : authorPosition!,
                              overflow: TextOverflow.clip,
                              style: Styles.listTitle.copyWith(
                                  fontSize: 16, fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'uploaded On:',
                                style: Styles.listTitle.copyWith(
                                    color: Styles.darkBlue, fontSize: 17),
                              ),
                            ),
                            // SizedBox(
                            //   width: MediaQuery.of(context).size.width * .45,
                            // ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                postedAt ?? '',
                                overflow: TextOverflow.ellipsis,
                                style: Styles.listTitle.copyWith(
                                    color: Styles.darkBlue,
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Deadline Date:',
                                style: Styles.listTitle.copyWith(
                                    color: Styles.darkBlue, fontSize: 17),
                              ),
                            ),
                            // SizedBox(
                            //   width: MediaQuery.of(context).size.width * .45,
                            // ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                deadlineDate ?? '',
                                overflow: TextOverflow.ellipsis,
                                style: Styles.listTitle.copyWith(
                                    color: Colors.red,
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic),
                              ),
                            ),
                          ],
                        ),
                        // Text(
                        //   isDeadlineAvailable?"Still Have enough Time":"No Time Lift",
                        //   style: Styles.listTitle
                        //       .copyWith(color: Colors.green, fontSize: 17),
                        // ),
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Done State:',
                          style: Styles.listTitle.copyWith(
                              color: Styles.darkBlue,
                              fontSize: 20,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              User? user = auth.currentUser;
                              String uid = user!.uid;
                              if (uid == widget.uploadedBy) {
                                FirebaseFirestore.instance
                                  .collection('tasks')
                                  .doc(widget.taskId)
                                  .update({'isDone': true});
                                  getData();
                              }else
                              {
                                Fluttertoast.showToast(
                                  msg:
                                      "You cant perform this Action",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 18.0);
                              }
                              
                            },
                            child: Text(
                              'Done',
                              style: Styles.listTitle.copyWith(
                                  color: Styles.darkBlue, fontSize: 17),
                            ),
                          ),
                          Opacity(
                            opacity: isDone == true ? 1 : 0,
                            child: const Icon(
                              Icons.check_box,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(
                            width: 35,
                          ),
                          TextButton(
                            onPressed: () {
                              User? user = auth.currentUser;
                              String uid = user!.uid;
                              if (uid == widget.uploadedBy) {
                                FirebaseFirestore.instance
                                  .collection('tasks')
                                  .doc(widget.taskId)
                                  .update({'isDone': false});
                                  getData();
                              }else
                              {
                                Fluttertoast.showToast(
                                  msg:
                                      "You cant perform this Action",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 18.0);
                              }
                            },
                            child: Text(
                              'Not Done yet',
                              style: Styles.listTitle.copyWith(
                                  color: Styles.darkBlue, fontSize: 17),
                            ),
                          ),
                          Opacity(
                            opacity: isDone == false ? 1 : 0,
                            child: const Icon(
                              Icons.check_box,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          taskDerscreption ?? '',
                          style: Styles.listTitle.copyWith(
                              color: Styles.darkBlue,
                              fontSize: 20,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: isCommenting
                          ? Row(
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      maxLines: 4,
                                      decoration: const InputDecoration(
                                        hintText: 'description',
                                        filled: true,
                                        // fillColor: Theme.of(context).scaffoldBackgroundColor,
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Styles.buttonColor),
                                        ),
                                      ),
                                      controller: _descriptionController,
                                      style: const TextStyle(
                                          color: Styles.darkBlue),
                                      maxLength: 100,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Field is empty';
                                        } else {
                                          return null;
                                        }
                                      },
                                      onSaved: (p0) {},
                                      obscureText: false,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25.0),
                                        child: CustomButton(
                                            text: 'Post',
                                            backgroundColor: Styles.buttonColor,
                                            borderSideColor: Colors.transparent,
                                            style: Styles.authenticationText15,
                                            onPressed: () {}),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: CustomButton(
                                            text: 'Cancel',
                                            backgroundColor: Styles.buttonColor,
                                            borderSideColor: Colors.transparent,
                                            style: Styles.authenticationText15,
                                            onPressed: () {
                                              setState(() {
                                                isCommenting = !isCommenting;
                                              });
                                            }),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 70.0, vertical: 50),
                              child: CustomButton(
                                  text: 'Add A Commment',
                                  backgroundColor: Styles.buttonColor,
                                  borderSideColor: Colors.transparent,
                                  style: Styles.authenticationText15,
                                  onPressed: () {
                                    setState(() {
                                      isCommenting = !isCommenting;
                                    });
                                  }),
                            ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
