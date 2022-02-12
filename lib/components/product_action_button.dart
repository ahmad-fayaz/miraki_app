import 'package:flutter/material.dart';
import 'package:miraki_app/constants/style.dart';

class ProductActionButton extends StatefulWidget {
  final Color color;
  final Color textColor;
  final String label;
  final Function() onTap;
  const ProductActionButton(
      {Key? key,
      required this.label,
      this.color = AppColor.primaryColor,
      this.textColor = AppColor.darkColor,
      required this.onTap})
      : super(key: key);

  @override
  _ProductActionButtonState createState() => _ProductActionButtonState();
}

class _ProductActionButtonState extends State<ProductActionButton> {
  bool _pressed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) => setState(() => _pressed = true),
      onTapUp: (details) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: () => widget.onTap(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        curve: Curves.fastOutSlowIn,
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
            color: !_pressed ? widget.color : AppColor.light,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: widget.color, width: 1.5),
            boxShadow: _pressed
                ? [
                    BoxShadow(
                        color: widget.color,
                        blurRadius: 4.0,
                        offset: const Offset(.1, .1))
                  ]
                : null),
        child: Center(
            child: Text(
          widget.label,
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: !_pressed ? widget.textColor : AppColor.darkColor),
        )),
      ),
    );
  }
}
