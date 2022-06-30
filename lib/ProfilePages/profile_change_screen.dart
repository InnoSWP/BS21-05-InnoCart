import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../navigation_bar.dart';
import '../main.dart';

class ProfileChangeScreen extends StatefulWidget {
  const ProfileChangeScreen({Key? key}) : super(key: key);

  @override
  State<ProfileChangeScreen> createState() => _ProfileChangeScreenState();
}

class _ProfileChangeScreenState extends State<ProfileChangeScreen> {
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
          bottomNavigationBar: makeNavigationBar(context, this),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: Column(
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  Container(
                    width: 130,
                    height: 160,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.blueGrey),
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
                                if (kDebugMode) {
                                  print('First text field: $text');
                                }
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
                                if (kDebugMode) {
                                  print('First text field: $text');
                                }
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
                            width: 125,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  side: const BorderSide(
                                      width: 2.0, color: Colors.black)),
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/ProfileScreen');
                              },
                              child: const Text(
                                'Go back',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 125,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  side: const BorderSide(
                                      width: 2.0, color: Colors.black)),
                              onPressed: () {},
                              child: const Text(
                                'Save',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
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
