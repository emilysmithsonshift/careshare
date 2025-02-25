import 'package:flutter/material.dart';

class Style {
  static BoxDecoration boxDecoration = BoxDecoration(
    borderRadius: const BorderRadius.all(
      Radius.circular(10),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 2,
        blurRadius: 3,
        offset: const Offset(1, 1),
      )
    ],
    color: Colors.white,
  );
}
