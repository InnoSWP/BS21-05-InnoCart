import 'package:flutter/material.dart';

ButtonStyle roundedWhite = ElevatedButton.styleFrom(
  primary: Colors.white,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
  ),
  elevation: 0,
  side: const BorderSide(color: Colors.black),
);
