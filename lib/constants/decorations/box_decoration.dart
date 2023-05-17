import 'package:flutter/material.dart';
import 'colors.dart';

BoxDecoration kCardDecoration = BoxDecoration(
  color: kCardBackgroundColor,
  borderRadius: BorderRadius.circular(8),
  boxShadow: [
    BoxShadow(
      color: Colors.grey[300]!,
      blurRadius: 8,
      spreadRadius: 2.5,
      offset: const Offset(0, 0),
    ),
  ],
);

BoxDecoration kIndicatorDecoration = BoxDecoration(
  color: kPrimaryDarkColor,
  borderRadius: BorderRadius.circular(100)
);

BoxDecoration kCircleRedRingDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(100),
  border: Border.all(
    color: Colors.red,
    width: 2,
  )
);

BoxDecoration kCancelDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(8),
  border: Border.all(
    color: Colors.red,
    width: 2,
  )
);

BoxDecoration kAcceptlDecoration = BoxDecoration(
  color: kPrimaryDarkColor,
  borderRadius: BorderRadius.circular(8),
);

BoxDecoration kScannerBoxlDecoration = BoxDecoration(
  // color: Colors.amber,
  borderRadius: BorderRadius.circular(20),
);