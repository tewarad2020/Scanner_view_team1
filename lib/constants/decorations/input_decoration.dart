import 'package:flutter/material.dart';
import 'package:scanner/constants/decorations/colors.dart';

InputDecoration kTextFieldDecoration = InputDecoration(
  // hintText: 'ระบุบาร์โค้ด ชื่อ หรือ ชื่อเล่นของสินค้า',
  hintText: 'ระบุบาร์โค้ด',
  filled: true,
  fillColor: kWhiteColor,
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: kPrimaryLightColor),
    borderRadius: BorderRadius.circular(8),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: kPrimaryLightColor),
    borderRadius: BorderRadius.circular(8),
  ),
  contentPadding: const EdgeInsets.all(10.0)
);

InputDecoration kAddNewProductTextFieldDecoration = InputDecoration(
  hintText: 'ชื่อสินค้า',
  filled: true,
  fillColor: Colors.white,
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: kPrimaryLightColor),
    borderRadius: BorderRadius.circular(8),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: kPrimaryLightColor),
    borderRadius: BorderRadius.circular(8),
  ),
  contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0)
);