import 'package:flutter/material.dart';
import 'package:scanner/constants/decorations/box_decoration.dart';
import 'package:scanner/constants/decorations/input_decoration.dart';
import 'package:scanner/constants/decorations/colors.dart';
import 'package:scanner/constants/decorations/text_style.dart';

class ScannedErrorCorrection extends StatefulWidget {
  const ScannedErrorCorrection({
    Key? key,
    required this.onUserPressedLeftButton,
    required this.onUserPressedRightButton,
    required this.setInputStr,
  }) : super(key: key);

  final Future<void> Function() onUserPressedLeftButton;
  final Future<void> Function() onUserPressedRightButton;
  final void Function({required String value}) setInputStr;

  @override
  State<ScannedErrorCorrection> createState() => _ScannedErrorCorrectionState();
}

class _ScannedErrorCorrectionState extends State<ScannedErrorCorrection> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      title: _correctionTitle(),
      content: Container(
        color: kWhiteColor,
        height: 60,
        child: _correctionContent()
      ),
      actions: <Widget>[
        _optionButton()
      ],
      titlePadding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
      contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      actionsPadding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      actionsAlignment: MainAxisAlignment.center,
    );
  }

  Container _correctionTitle() {
    return Container(
      color: kWhiteColor,
      child:  Text(
        'ระบุด้วยตนเอง',
        style: kSubHeaderTextStyle.copyWith(fontSize: 22),
        textAlign: TextAlign.start,
      ),
    );
  }

  Container _correctionContent() {
    return Container(
      color: kWhiteColor,
      child: Center(
        child: SizedBox(
          height: 47,
          child: TextField(
            textAlignVertical: TextAlignVertical.center,
            style: kConfirmDeleteContentTextStyle,
            decoration: kTextFieldDecoration,
            onChanged: (value) {
              widget.setInputStr(value: value);
              setState(() {});
            },
          ),
        ),
      ),
    );
  }

  Container _optionButton() {
    return Container(
      color: kWhiteColor,
      child: Row(
        children: [
          _actionButton(
            margin: const EdgeInsets.only(
              right: 8,
            ),
            decoration: kCancelDecoration,
            buttonText: 'ยกเลิก',
            style: kAlerContentTextStyle,
            onPressed: () async {
              await widget.onUserPressedLeftButton();
            }
          ),
          _actionButton(
            margin: const EdgeInsets.only(
              left: 8,
            ),
            decoration: kAcceptlDecoration,
            buttonText: 'ยืนยัน',
            style: kAlertButtonWhiteTextStyle,
            onPressed: () async {
              await widget.onUserPressedRightButton();
            }
          ),
        ],
      ),
    );
  }

  Expanded _actionButton({
      required EdgeInsets margin, 
      required BoxDecoration decoration, 
      required String buttonText,
      required TextStyle style,
      required VoidCallback onPressed
    }) {
    return Expanded(
      child: Container(
        height: 50,
        padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
        margin: margin,
        decoration: decoration,
        child: TextButton(
          onPressed: onPressed, 
          child: Text(
            buttonText,
            style: style,
          )
        ),
      ),
    );
  }

}