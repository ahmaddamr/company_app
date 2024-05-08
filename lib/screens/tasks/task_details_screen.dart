import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop_app/screens/auth/widgets/custom_button.dart';
import 'package:shop_app/screens/tasks/widgets/drawer_widget.dart';
import 'package:shop_app/utils/styles.dart';

class TaskDetailsScreen extends StatefulWidget {
  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  // const TaskDetailsScreen({super.key});
  late TextEditingController _descriptionController =
      TextEditingController(text: '');

  bool isCommenting = false;

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
              'Develop An App',
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
                        CircleAvatar(
                          radius: 25,
                          child: Image.network(
                            'https://cdn-icons-png.flaticon.com/128/3135/3135715.png',
                            width: 100,
                            height: 100,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mark Morph',
                              overflow: TextOverflow.clip,
                              style: Styles.listTitle.copyWith(
                                  fontSize: 16, fontStyle: FontStyle.italic),
                            ),
                            Text(
                              'Web Designer',
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
                            Text(
                              '9/7/2021',
                              overflow: TextOverflow.ellipsis,
                              style: Styles.listTitle.copyWith(
                                  color: Styles.darkBlue,
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic),
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
                            Text(
                              '9/7/2021',
                              overflow: TextOverflow.ellipsis,
                              style: Styles.listTitle.copyWith(
                                  color: Colors.red,
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                        Text(
                          'Still Have Time',
                          style: Styles.listTitle
                              .copyWith(color: Colors.green, fontSize: 17),
                        ),
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
                          Text(
                            'Done',
                            style: Styles.listTitle
                                .copyWith(color: Styles.darkBlue, fontSize: 17),
                          ),
                          const Opacity(
                            opacity: 1,
                            child: Icon(
                              Icons.check_box,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(
                            width: 35,
                          ),
                          Text(
                            'Not Done yet',
                            style: Styles.listTitle
                                .copyWith(color: Styles.darkBlue, fontSize: 17),
                          ),
                          const Opacity(
                            opacity: 0,
                            child: Icon(
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
                          'Task Description:',
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
