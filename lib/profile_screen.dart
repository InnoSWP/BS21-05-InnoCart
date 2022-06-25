import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:inno_cart/backend_functions.dart';
import 'navigation_bar.dart';
import 'user.dart';
import 'backend_functions.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: makeNavigationBar(context, this),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 70),
        child: Column(
          children: [
            const SizedBox(
              height: 70,
            ),
            Container(
              width: 130,
              height: 160,
              decoration:
                  const BoxDecoration(shape: BoxShape.circle, color: Colors.blueGrey),
            ),
            const SizedBox(
              height: 15,
            ),
            RatingBar.builder(
              initialRating: 3.5,
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
                  children: const [Text('E-mail'), Text('ivanovivan@gmail.com')],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [Text('Telegram'), Text('@anekdot')],
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: SizedBox(
                    height: 35,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          side: const BorderSide(width: 2.0, color: Colors.black)),
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, '/ProfileChangeScreen');
                      },
                      child: const Text(
                        'Edit profile',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    height: 35,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          side: const BorderSide(width: 2.0, color: Colors.black)),
                      onPressed: () {
                        currentUser = User(getEmptyMap());
                        Navigator.pushReplacementNamed(
                            context, '/');
                      },
                      child: const Text(
                        'Log out',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
