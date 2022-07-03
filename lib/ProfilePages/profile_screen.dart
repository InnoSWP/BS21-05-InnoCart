import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inno_cart/UI/Buttons/elevated_button_style.dart';
import '../backend_functions.dart';
import '../navigation_bar.dart';
import '../user.dart';
import '../main.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';

class ProfilePage extends StatefulWidget {
  final int ok;
  final double rating;
  final String telegram;
  final String email;

  const ProfilePage(
      {Key? key,
      this.ok = 0,
      this.rating = 4,
      this.telegram = "",
      this.email = ""})
      : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

PlatformFile? pickedFile = null;

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onHorizontalDragEnd: ((DragEndDetails details) {
          if (widget.ok == 0) {
            if (details.primaryVelocity! < 3.0) {
              pageUpdate((selectedPage + 1) % 5, context);
            } else if (details.primaryVelocity! > 3.0) {
              pageUpdate((selectedPage + 4) % 5, context);
            }
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

                  CircleAvatar(radius: 90, backgroundImage:pickedFile != null
                      ? Image.file(
                    File(pickedFile!.path!),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ).image
                      : Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGrvu5dvNWm3aeTwcEfGy5uW2nTSI6dMU-ENCRvcL7UGS7sEYfNTvhFx6_gnajDWE8uLQ&usqp=CAU').image,),

                  const SizedBox(
                    height: 15,
                  ),
                  RatingBar.builder(
                    initialRating: widget.rating,
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text('E-mail: '),
                          Text(widget.email),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text('Telegram: @'),
                          Text(widget.telegram)
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Builder(builder: (BuildContext context) {
                        if (widget.ok == 0) {
                          return Column(
                            children: [
                              Center(
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 15),
                                  width: 130,
                                  height: 35,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                        side: const BorderSide(
                                            width: 2.0, color: Colors.black)),
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                          context, '/ProfileChangeScreen');
                                    },
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Edit profile',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          SvgPicture.asset(
                                              'assets/icons/Pencil.svg')
                                        ]),
                                  ),
                                ),
                              ),
                              Center(
                                child: SizedBox(
                                  width: 115,
                                  height: 35,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.white,
                                          side: const BorderSide(
                                              width: 2.0, color: Colors.black)),
                                      onPressed: () async {
                                        currentUser = User(getEmptyMap());
                                        final directory =
                                            await getApplicationDocumentsDirectory();
                                        File file =
                                            File('${directory.path}/data.json');
                                        file.delete();
                                        Navigator.pushReplacementNamed(
                                            context, '/start');
                                      },
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Log out',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            Icon(
                                              Icons.logout,
                                              color: Colors.black,
                                            )
                                          ])),
                                ),
                              )
                            ],
                          );
                        } else {
                          return ElevatedButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed('/ProfileScreen');
                            },
                            style: roundedWhite,
                            child: const TextAndArrowButtonChild(
                              buttonText: 'Return to profile',
                            ),
                          );
                        }
                      })
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
