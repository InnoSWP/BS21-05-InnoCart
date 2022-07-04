import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:inno_cart/firebase_functions.dart';
import '../backend_functions.dart';
import '../navigation_bar.dart';
import '../main.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'profile_screen.dart';

class ProfileChangeScreen extends StatefulWidget {
  const ProfileChangeScreen({Key? key}) : super(key: key);

  @override
  State<ProfileChangeScreen> createState() => _ProfileChangeScreenState();
}

class _ProfileChangeScreenState extends State<ProfileChangeScreen> {
  Map<String, String> dataToUpdate = {"email": "", "telegram": ""};

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onHorizontalDragEnd: ((DragEndDetails details) {
          if (details.primaryVelocity! < 0.0) {
            pageUpdate((selectedPage + 1) % 5, context);
          } else if (details.primaryVelocity! > 0.0) {
            pageUpdate((selectedPage + 4) % 5, context);
          }
        }),
        child: Scaffold(
          bottomNavigationBar: const MainNavigationBar(),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: Column(
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  CircleAvatar(
                    radius: 90,
                    backgroundImage: pickedFile != null
                        ? Image.file(
                            File(pickedFile!.path!),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ).image
                        : Image.network(
                            'https://www.pngkit.com/png/detail/129-1298005_png-file-upload-image-icon-png.png',
                            fit: BoxFit.cover,
                          ).image,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            side: const BorderSide(
                                width: 2.0, color: Colors.black)),
                        onPressed: (() async => selectFile()),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                'Change avatar',
                                style: TextStyle(color: Colors.black),
                              ),
                              Icon(
                                Icons.account_box,
                                color: Colors.black,
                              )
                            ])),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  RatingBar.builder(
                    initialRating: 2.5,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      if (kDebugMode) {
                        print(rating);
                      }
                    },
                  ),
                  const SizedBox(height: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Contact Information'),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('E-mail'),
                          SizedBox(
                            width: 150,
                            height: 30,
                            child: TextField(
                              onChanged: (text) {
                                dataToUpdate['email'] = text;
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7.0)),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7.0)),
                                ),
                                hintText: 'Enter E-mail',
                                contentPadding:
                                    EdgeInsets.only(top: 7, left: 5),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Telegram'),
                          SizedBox(
                            width: 150,
                            height: 30,
                            child: TextField(
                              onChanged: (text) {
                                dataToUpdate['telegram'] = text;
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7.0)),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7.0)),
                                ),
                                hintText: 'Enter alias',
                                contentPadding:
                                    EdgeInsets.only(top: 7, left: 5),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 115,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    side: const BorderSide(
                                        width: 2.0, color: Colors.black)),
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/ProfileScreen');
                                },
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        Icons.arrow_back_ios_outlined,
                                        color: Colors.black,
                                      ),
                                      const Text(
                                        'Go back',
                                        style: TextStyle(color: Colors.black),
                                      )
                                    ])),
                          ),
                          SizedBox(
                            width: 125,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    side: const BorderSide(
                                        width: 2.0, color: Colors.black)),
                                onPressed: () async {
                                  bool result = await updateContactInformation(
                                      dataToUpdate['email'] ?? "Unknown",
                                      dataToUpdate['telegram'] ?? "Unknown");
                                  if (result) {
                                    pushAvatarFirebaseStorage(
                                        pickedFile, currentUser.userId);
                                    Navigator.pushReplacementNamed(
                                        context, '/ProfileScreen');
                                  }
                                },
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Text(
                                        'Save',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      Icon(
                                        Icons.check,
                                        color: Colors.black,
                                      )
                                    ])),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
