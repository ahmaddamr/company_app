// ignore_for_file: avoid_print
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/screens/auth/widgets/custom_button.dart';
import 'package:shop_app/screens/auth/widgets/custom_text_field.dart';
import 'package:shop_app/screens/auth/widgets/rich_text_widget.dart';
import 'package:shop_app/screens/auth/widgets/sign_errors_dialoge.dart';
import 'package:shop_app/utils/styles.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignUpScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late TextEditingController _emailController = TextEditingController(text: '');
  late TextEditingController _passController = TextEditingController(text: '');
  late TextEditingController _FullNameController =
      TextEditingController(text: '');
  late TextEditingController _positionController =
      TextEditingController(text: 'Position');
  // ignore: prefer_typing_uninitialized_variables
  var imgFile;
  bool isSecurePassword = true;
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();
  // 1st Step for authentication
  final FirebaseAuth auth = FirebaseAuth.instance;
  String? photoUrl;
  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    _passController.dispose();
    _FullNameController.dispose();
    _positionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 20));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((animationListener) {
            if (animationListener == AnimationStatus.completed) {
              _animationController.reset();
              _animationController.forward();
            }
          });
    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        body: Stack(
          children: [
            CachedNetworkImage(
              imageUrl:
                  "https://th.bing.com/th/id/OIP.84UzNIsqNeHdkxyR5F1RlgHaHa?pid=ImgDet&w=178&h=178&c=7&dpr=1.3",
              placeholder: (context, url) => Image.asset(
                'assets/images/wallpaper.jpg',
                fit: BoxFit.fill,
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              alignment: FractionalOffset(_animation.value, 0),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  const Text(
                    'Signup',
                    style: Styles.authenticationText30,
                  ),
                  const RichTextWidget(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: CustomTextFormField(
                          controller: _FullNameController,
                          hint: 'Full Name',
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
                      Flexible(
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  border:
                                      Border.all(color: Colors.white, width: 1),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: imgFile == null
                                      ? Image.network(
                                          'https://cdn-icons-png.flaticon.com/128/3177/3177440.png',
                                          fit: BoxFit.fill,
                                        )
                                      : Image.file(
                                          imgFile,
                                          fit: BoxFit.fill,
                                        ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  pickImgDialoge();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Styles.buttonColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.white, width: 2),
                                  ),
                                  child: Icon(
                                    imgFile == null
                                        ? Icons.add_a_photo
                                        : Icons.edit_outlined,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                              'Job Title',
                              style: TextStyle(color: Styles.buttonColor),
                            ),
                            content: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.1,
                              // height: MediaQuery.of(context).size.height * 0.4,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: Styles.jobsList.length,
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
                                            _positionController.text =
                                                Styles.jobsList[index];
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          Styles.jobsList[index],
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
                    child: CustomTextFormField(
                      enabled: false,
                      controller: _positionController,
                      hint: 'Position',
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  CustomTextFormField(
                    controller: _emailController,
                    hint: 'Email',
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  CustomTextFormField(
                    suffixIcon: passwordShow(),
                    controller: _passController,
                    hint: 'Password',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Field is empty';
                      }
                      if (value.length < 7) {
                        return 'Password must be more than 7 letters';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (p0) {},
                    obscureText: isSecurePassword,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : CustomButton(
                          text: 'SignUp',
                          backgroundColor: Styles.buttonColor,
                          borderSideColor: Colors.transparent,
                          style: Styles.authenticationText15,
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              if (imgFile == null) {
                                const SignErrorsDialoge(
                                  error: 'Please pickup an image',
                                );
                              }
                              setState(() {
                                isLoading = true;
                              });
                              try {
                                final credential = await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                  email: _emailController.text.trim(),
                                  password: _passController.text.trim(),
                                );
                                final User? user = auth.currentUser;
                                final Id = user!.uid;
                                //function to upload profile img to firebase storage
                                final url = FirebaseStorage.instance
                                    .ref()
                                    .child('userIMages')
                                    .child(Id + '.jpg');
                                await url.putFile(imgFile);
                                photoUrl = await url.getDownloadURL();
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc('Id')
                                    .set({
                                  'id': Id,
                                  'name': _FullNameController.text,
                                  'email': _emailController.text,
                                  'userImage': photoUrl,
                                  'position': _positionController.text,
                                  'createdAt': Timestamp.now()
                                });
                                Navigator.of(context).pushNamed('TasksScreen');
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'weak-password') {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const SignErrorsDialoge(
                                        error:
                                            'The password provided is too weak.',
                                      );
                                    },
                                  );
                                  print('The password provided is too weak.');
                                } else if (e.code == 'email-already-in-use') {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const SignErrorsDialoge(
                                        error:
                                            'The account already exists for that email.',
                                      );
                                    },
                                  );
                                  print(
                                      'The account already exists for that email.');
                                }
                              } catch (e) {
                                print(e);
                              }
                            } else {
                              print('not valid');
                            }
                            setState(() {
                              isLoading = false;
                            });
                          },
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget passwordShow() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSecurePassword = !isSecurePassword;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
        child: Icon(
          isSecurePassword ? Icons.visibility : Icons.visibility_off,
          color: Colors.white,
        ),
      ),
    );
  }

  void pickImgDialoge() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Choose an Option'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: pickImgWithCamera,
                child: const Row(
                  children: [
                    Icon(
                      Icons.camera,
                      color: Styles.buttonColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Camera',
                      style: Styles.addTask,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: pickImgWithGallery,
                child: const Row(
                  children: [
                    Icon(
                      Icons.photo_album,
                      color: Styles.buttonColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Gallery',
                      style: Styles.addTask,
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void pickImgWithCamera() async {
    XFile? pickedfile = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxHeight: 1080, maxWidth: 1080);
    if (pickedfile != null) {
      setState(() {
        imgFile = File(pickedfile.path);
      });
    }
    // if (pickedfile != null) {
    //   cropImg(pickedfile.path);
    // }
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  void pickImgWithGallery() async {
    XFile? pickedfile = await ImagePicker().pickImage(
        source: ImageSource.gallery, maxHeight: 1080, maxWidth: 1080);
    if (pickedfile != null) {
      setState(() {
        imgFile = File(pickedfile.path);
      });
    }
    // if (pickedfile != null) {
    //   cropImg(pickedfile.path);
    // }
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  void cropImg(filePath) async {
    CroppedFile? croppedFile = await ImageCropper.platform
        .cropImage(sourcePath: filePath, maxHeight: 1080, maxWidth: 1080);
    if (croppedFile != null) {
      setState(() {
        imgFile = croppedFile;
      });
    }
  }
}
