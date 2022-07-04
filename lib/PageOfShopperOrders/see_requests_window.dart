import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'page_of_shopper_orders.dart';
import '../UI/PopUpWindows/order_canceled.dart';
import '../backend_functions.dart';
import '../UI/Buttons/elevated_button_style.dart';

Future seeRequestWindow(
    BuildContext context, int ticketId, PageOfShopperOrdersState page) {
  String buttonText = 'Cancel Order';
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        child: FutureBuilder<List<Widget>>(
            future: AngelOffer.getOffers(ticketId, page),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SizedBox(
                  height: 300,
                  child: Column(
                    children: snapshot.data! +
                        [
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            width: 130,
                            child: ElevatedButton(
                              onPressed: () async {
                                // Navigator.of(context).pop();
                                bool result = await cancelOrder(ticketId);
                                if (result) {
                                  Navigator.of(context).pop();
                                  popUpOrderCanceled(context);
                                  page.setState(() {});
                                }
                              },
                              style: roundedWhite,
                              child: Text(
                                buttonText,
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      );
    },
  );
}

class AngelOffer extends StatelessWidget {
  static const String buttonText = "Accept";
  static const String profilePicture =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGrvu5dvNWm3aeTwcEfGy5uW2nTSI6dMU-ENCRvcL7UGS7sEYfNTvhFx6_gnajDWE8uLQ&usqp=CAU';
  final String shopperName;
  final double shopperRating;
  final int offerId;
  final PageOfShopperOrdersState page;

  const AngelOffer(
      this.offerId, this.shopperName, this.shopperRating, this.page,
      {Key? key})
      : super(key: key);

  static Future<List<Widget>> getOffers(
      int ticketId, PageOfShopperOrdersState page) async {
    List<Widget> listToReturn = [];
    Map<String, dynamic> data = await getOffersByTicketId(ticketId);
    for (Map<String, dynamic> offer in data['offers']) {
      listToReturn.add(AngelOffer(offer['offer_id'], offer['angel']['name'],
          offer['angel']['rating'], page));
    }
    return listToReturn;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        //margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: (20),
                  backgroundImage: NetworkImage(profilePicture),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    children: [
                      Text(shopperName),
                      RatingBar.builder(
                        initialRating: shopperRating,
                        ignoreGestures: true,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 10,
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
                    ],
                  ),
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  acceptOffer(offerId);
                  Navigator.pop(context);
                  page.setState(() {});
                },
                style: roundedWhite,
                child: SizedBox(
                  width: 90,
                  height: 32,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        buttonText,
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black,
                        size: 14,
                      ),
                    ],
                  ),
                )),
          ],
        ));
  }
}
