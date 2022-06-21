import 'package:flutter/material.dart';

ButtonStyle RoundedWhite = ElevatedButton.styleFrom(
  primary: Colors.white,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
  ),
  elevation: 0,
  side: BorderSide(color: Colors.black),
);
