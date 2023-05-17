import 'package:flutter/material.dart';
import 'package:scanner/constants/decorations/box_decoration.dart';
import 'package:scanner/constants/decorations/text_style.dart';
import 'package:scanner/constants/decorations/colors.dart';
import 'package:scanner/modules/scanner/product.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key? key,
    required this.model,
    required this.onUserPressedDeleteButton,
  }) : super(key: key);

  final Product model;
  final void Function() onUserPressedDeleteButton;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Container build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 7,
        left: 5,
        right: 5,
        bottom: 0
      ),
      padding: const EdgeInsets.all(8),
      decoration: kCardDecoration,
      height: 68,
      child: Row(
        children: <Widget>[
          _indicator(),
          _productName(),
          _deleteButton()
        ],
      ),
    );
  }

  Expanded _indicator() {
    return Expanded(
      flex: 2,
      child: Container(
        color: kWhiteColor,
        child: Center(
          child: Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: kIndicatorDecoration,
                child: Center(
                  child: Text(
                    widget.model.itemsInCardList.toString(),
                    style: kIndicatorTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded _productName() {
    return Expanded(
      flex: 9,
      child: Container(
        color: kWhiteColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.model.name.toString(),
              style: kTitleTextStyle,
            ),
            Text(
              widget.model.barcode.toString(),
              style: kSubTitleFadedTextStyle,
            ),
          ],
        )
      ),
    );
  }

  Expanded _deleteButton() {
    return Expanded(
      flex: 2,
      child: Container(
        color: kWhiteColor,
        child: Center(
          child: IconButton(
            icon: const Icon(
              Icons.delete,
              size: 28,
              color: kGrayColor,
            ),
            onPressed: () {
              setState(() {});
              widget.onUserPressedDeleteButton();
            },
          )
        )
      ),
    );
  }

}