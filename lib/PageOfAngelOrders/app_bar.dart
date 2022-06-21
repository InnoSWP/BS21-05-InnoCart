import 'package:flutter/material.dart';

PreferredSizeWidget? appBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    title: ElevatedButton(
      onPressed: () =>
          Navigator.of(context).pushReplacementNamed('/ShopperOrders'),
      style: ElevatedButton.styleFrom(primary: Colors.yellowAccent),
      child: Container(
        width: 270,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Padding(
              padding: EdgeInsets.only(right: 45),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 16,
              ),
            ),
            Text('Move to Shopper page',
                style: TextStyle(color: Colors.black, fontSize: 16)),
          ],
        ),
      ),
    ),
  );
}
