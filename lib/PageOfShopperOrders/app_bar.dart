import 'package:flutter/material.dart';

PreferredSizeWidget? appBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    title: ElevatedButton(
      onPressed: () {
        Navigator.of(context).pushReplacementNamed('/AngelOrders');
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.yellowAccent,
      ),
      child: SizedBox(
        width: 270,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Text('Move to Angel page',
                style: TextStyle(color: Colors.black, fontSize: 16)),
            Padding(
              padding: EdgeInsets.only(left: 45),
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
