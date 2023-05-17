import 'package:flutter/material.dart';
import 'package:scanner/constants/decorations/box_decoration.dart';
import 'package:scanner/constants/decorations/colors.dart';
import 'package:scanner/constants/decorations/text_style.dart';

class ConfirmDelete extends StatefulWidget {
  const ConfirmDelete({
    Key? key,
    required this.icon,
    required this.title,
    required this.content,
    required this.leftButtonText,
    required this.rightButtonText,
    required this.onUserPressedAcceptButton,
    required this.onUserPressedCancelButton,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final String content;
  final String leftButtonText;
  final String rightButtonText;
  final void Function() onUserPressedAcceptButton;
  final void Function() onUserPressedCancelButton;

  @override
  State<ConfirmDelete> createState() => _ConfirmDeleteState();
}

class _ConfirmDeleteState extends State<ConfirmDelete> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      title: _alertIcon(),
      content: Container(
        color: kWhiteColor,
        height: 60,
        child: Column(
          children: [
            _alertTitle(),
            _alertContent(),
          ],
        ),
      ),
      actions: <Widget>[
        _confirmButton()
      ],
      titlePadding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
      contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      actionsPadding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      actionsAlignment: MainAxisAlignment.center,
    );
  }

  Column _alertIcon() {
    return Column(
      children: [
        Container(
          height: 70,
          width: 70,
          decoration: kCircleRedRingDecoration,
          child: Center(
            child: Icon(
              widget.icon,
              size: 50,
              color: kRedTextColor,
            ),
          ),
        ),
      ],
    );
  }

  Container _alertTitle() {
    return Container(
      color: kWhiteColor,
      child: Text(
        widget.title,
        style: kSubHeaderTextStyle,
        textAlign: TextAlign.center,
      ),
    );
  }

  Container _alertContent() {
    return Container(
      color: kWhiteColor,
        child: Text(
          widget.content,
          style: kConfirmDeleteContentTextStyle,
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
            onPressed: () {
              widget.onUserPressedCancelButton();
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
            onPressed: () {
              setState(() {});
              widget.onUserPressedAcceptButton();
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
        padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
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