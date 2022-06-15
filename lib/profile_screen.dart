import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 70),
        child: Column(
          children: [
            SizedBox(
              height: 70,
            ),
            Container(
              width: 130,
              height: 160,
              decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.blueGrey),
            ),
            SizedBox(
              height: 15,
            ),
            RatingBar.builder(
              initialRating: 3.5,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
            SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Contact Information'),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('E-mail'), Text('ivanovivan@gmail.com')],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Telegram'), Text('@anekdot')],
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: SizedBox(height: 35, child:ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        side: BorderSide(width: 2.0, color: Colors.black)),
                    onPressed: () {},
                    child: Text(
                      'Edit profile',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}