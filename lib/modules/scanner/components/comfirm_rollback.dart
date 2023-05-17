import 'package:flutter/material.dart';
import 'package:scanner/constants/decorations/colors.dart';
import 'package:scanner/constants/decorations/text_style.dart';

class ConfirmRollback extends StatefulWidget {
  const ConfirmRollback({
    Key? key,
    required this.title,
    required this.data,
    required this.leftButtonText,
    required this.rightButtonText,
    required this.onUserPressedLeftButton,
    required this.onUserPressedRightButton,
  }) : super(key: key);

  final String title;
  final String data;
  final String leftButtonText;
  final String rightButtonText;
  final Future<void> Function() onUserPressedLeftButton;
  final Future<void> Function() onUserPressedRightButton;

  @override
  State<ConfirmRollback> createState() => _ConfirmRollbackState();
}

class _ConfirmRollbackState extends State<ConfirmRollback> {
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
      titlePadding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
      contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      actionsPadding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      actionsAlignment: MainAxisAlignment.center,
    );
  }

  Container _alertTitle() {
    return Container(
      color: kWhiteColor,
      child: Center(
        child: Text(
          widget.title,
          style: kAlerTitleTextStyle,
        ),
      ),
    );
  }

  Container _alertContent() {
    return Container(
      color: kWhiteColor,
        child: Text(
          widget.data,
          style: kSubHeaderTextStyle,
          textAlign: TextAlign.center,
        ),
    );
  }

  Container _confirmButton() {
    return Container(
      color: kWhiteColor,
      child: Row(
        children: [
          _actionButton(
            margin: const EdgeInsets.only(
              right: 8,
            ),
            color: kGreyButtonColor,
            radius: 8,
            buttonText: widget.leftButtonText,
            style: kAlertButtonWhiteTextStyle,
            onPressed: () async {
              await widget.onUserPressedLeftButton();
            }
          ),
          _actionButton(
            margin: const EdgeInsets.only(
              left: 8,
            ),
            color: kSkyButtonColor,
            radius: 8,
            buttonText: widget.rightButtonText,
            style: kAlertButtonDarkTextStyle,
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
      required Color color, 
      required double radius,
      required String buttonText,
      required TextStyle style,
      required VoidCallback onPressed
    }) {
    return Expanded(
      child: Container(
        height: 50,
        padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
        margin: margin,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius),
        ),
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