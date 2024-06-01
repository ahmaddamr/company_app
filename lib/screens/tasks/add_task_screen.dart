// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/screens/auth/widgets/custom_button.dart';
import 'package:shop_app/utils/styles.dart';
import 'package:uuid/uuid.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});
  static String id = 'AddTaskScreen';

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  late TextEditingController _categoryController =
      TextEditingController(text: 'Task Category');

  late TextEditingController _titleController = TextEditingController(text: '');

  late TextEditingController _descriptionController =
      TextEditingController(text: '');

  late TextEditingController _dateController =
      TextEditingController(text: 'Pick up a Date');

  GlobalKey<FormState> formKey = GlobalKey();
  DateTime? pickup;
  Timestamp? deadlineDateTimestamp;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _categoryController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        // drawer: const DrawerWidget(),
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Card(
                elevation: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'All Fields are Required',
                        style: TextStyle(
                            fontSize: 25,
                            color: Color.fromARGB(255, 50, 3, 181),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.015,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Task Category*',
                        style: Styles.addTask,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text(
                                  'Task Category',
                                  style: TextStyle(color: Styles.buttonColor),
                                ),
                                content: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
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
                                                _categoryController.text =
                                                    Styles.categoryList[index];
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              Styles.categoryList[index],
                                              style:
                                                  const TextStyle(fontSize: 18),
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
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  )
                                ],
                              );
                            },
                          );
                        },
                        child: TextFormField(
                          decoration: InputDecoration(
                            filled: true,
                            enabled: false,
                            fillColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Styles.buttonColor),
                            ),
                          ),
                          controller: _categoryController,
                          style: const TextStyle(color: Styles.darkBlue),
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
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.05,
                    // ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Task title*',
                        style: Styles.addTask,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Theme.of(context).scaffoldBackgroundColor,
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Styles.buttonColor),
                          ),
                        ),
                        controller: _titleController,
                        style: const TextStyle(color: Styles.darkBlue),
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
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Task Description*',
                        style: Styles.addTask,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Theme.of(context).scaffoldBackgroundColor,
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Styles.buttonColor),
                          ),
                        ),
                        controller: _descriptionController,
                        style: const TextStyle(color: Styles.darkBlue),
                        maxLength: 1000,
                        maxLines: 3,
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
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Deadline date*',
                        style: Styles.addTask,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {
                          datePicker();
                        },
                        child: TextFormField(
                          enabled: false,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Styles.buttonColor),
                            ),
                          ),
                          controller: _dateController,
                          style: const TextStyle(color: Styles.darkBlue),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 25.0, horizontal: 120),
                      child: CustomButton(
                          text: 'upload',
                          backgroundColor: Styles.buttonColor,
                          borderSideColor: Colors.transparent,
                          style: Styles.authenticationText15,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();

                              print('valid');
                            } else {
                              print('not valid');
                            }
                            final isValid = formKey.currentState!.validate();
                            if (isValid) {
                              if (_dateController.text == 'Pick up a Date' ||
                                  _categoryController.text == 'Task Category') {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return showError();
                                  },
                                );
                                return;
                              }
                              addTaskFirebase();
                              Fluttertoast.showToast(
                                  msg: "Task uploaded Succesfuly",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 18.0);
                                  _categoryController.clear();
                                  _dateController.clear();
                                  _descriptionController.clear();
                                  _titleController.clear();
                            } else {
                              const Text('Form not Valid');
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void datePicker() async {
    pickup = await showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(
        const Duration(days: 0),
      ),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );
    if (pickup != null) {
      setState(() {
        _dateController.text =
            '${pickup!.year}-${pickup!.month}-${pickup!.day}';
      });
    }
  }

  void addTaskFirebase() async {
    User? user = auth.currentUser;
    final String id = user!.uid;
    final taskId = Uuid().v4();
    await FirebaseFirestore.instance.collection('tasks').doc(taskId).set({
      'taskId': taskId,
      'uploadedBy': id,
      'taskTitle': _titleController.text,
      'taskDerscreption': _descriptionController.text,
      'deadlineDate': _dateController.text,
      'deadlineDateTimestamp':deadlineDateTimestamp,
      'taskCategory': _categoryController.text,
      'createdAt': Timestamp.now(),
      'isDone':false
    });
  }

  Widget showError() {
    return AlertDialog(
      title: Row(
        children: [
          Image.network(
            'https://cdn-icons-png.flaticon.com/128/14090/14090276.png',
            height: 25,
            width: 25,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Error'),
          )
        ],
      ),
      content: const Text(
        'please pickUp Date And Category',
        style: Styles.listTile,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Cancel',
            style: TextStyle(fontSize: 15),
          ),
        ),
      ],
    );
  }
}
