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
      style: ElevatedButton.styleFrom(primary: Colors.yellowAccent),
      child: const Text('Move to Angel page',
          style: TextStyle(color: Colors.black, fontSize: 16)),
    ),
  );
}
