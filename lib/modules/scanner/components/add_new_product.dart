import 'package:flutter/material.dart';
import 'package:scanner/constants/decorations/box_decoration.dart';
import 'package:scanner/constants/decorations/input_decoration.dart';
import 'package:scanner/constants/decorations/colors.dart';
import 'package:scanner/constants/decorations/text_style.dart';


class AddNewProduct extends StatefulWidget {
  const AddNewProduct({
    Key? key,
    required this.onUserPressedBackButton,
    required this.onUserPressedUpdateButton,
  }) : super(key: key);

  final Future<void> Function() onUserPressedBackButton; 
  final Future<void> Function() onUserPressedUpdateButton; 

  @override
  State<AddNewProduct> createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      title: _alertTitle(),
      content: _alertContent(),
      actions: <Widget>[
        _confirmButton()
      ],
      titlePadding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      actionsPadding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      actionsAlignment: MainAxisAlignment.center,
    );
  }

  Row _alertTitle() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            color: kWhiteColor,
            padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Transform.scale(
                scale: 2,
                child: IconButton(
                  padding: const EdgeInsets.all(0.0),
                  icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: kPrimaryDarkColor,
                      size: 30,
                  ),
                  onPressed: () async {
                    await widget.onUserPressedBackButton();
                  }
                ),
              ),
            ),
          ), 
        ),
        Expanded(
          flex: 6,
          child: Center(
            child: Text(
              'เพิ่มสินค้าใหม่',
              style: kAlertButtonDarkTextStyle.copyWith(fontSize: 26),
            ),
          ),
        )
      ],
    );
  }

  Container _alertContent() {
    return Container(
      color: kWhiteColor,
      height: 260,
        child: Column(
          children: <Widget>[
            _detailBox(title: 'ชื่อสินค้า'),
            _detailBox(title: 'ชื่อเล่น'),
            _detailBox(title: 'บาร์โค้ด'),
            _detailBox(title: 'ราคา'),
            _detailBox(title: 'หมวดหมู่'),
          ],
        )
    );
  }

  Expanded _detailBox({required String title}) {
    return Expanded(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Text(
              title,
              style: kHighLightBodyTextStyle.copyWith(fontSize: 20),
            ),
          ),
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 35,
              child: TextField(
                textAlignVertical: TextAlignVertical.center,
                style: kHighLightBodyTextStyle.copyWith(fontSize: 20),
                decoration: kAddNewProductTextFieldDecoration,
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
          ),
        ],
      )
    );
  }

  Container _confirmButton() {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              decoration: kAcceptlDecoration.copyWith(color: kSkyButtonColor),
              child: TextButton(
                onPressed: () async {
                  await widget.onUserPressedUpdateButton();
                }, 
                child: const Text(
                  'บันทึกข้อมูล',
                  style: kAlertButtonDarkTextStyle,
                )
              ),
            ),
          )
        ],
      ),
    );
  }
}