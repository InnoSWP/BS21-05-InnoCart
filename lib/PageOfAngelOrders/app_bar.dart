import 'package:flutter/material.dart';

PreferredSizeWidget? appBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    title: ElevatedButton(
      onPressed: () =>
          Navigator.of(context).pushReplacementNamed('/ShopperOrders'),
      style: ElevatedButton.styleFrom(primary: Colors.yellowAccent),
      child: const Text('Move to Shopper page',
          style: TextStyle(color: Colors.black, fontSize: 16)),
    ),
  );
}
