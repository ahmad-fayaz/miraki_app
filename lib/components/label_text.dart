import 'package:flutter/material.dart';
import 'package:miraki_app/constants/style.dart';

class LabelText extends StatelessWidget {
  final String label;
  final String value;
  const LabelText({Key? key, required this.label, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: '$label: ',
          style: const TextStyle(color: AppColor.darkColor)),
      TextSpan(
          text: value,
          style: const TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
              color: AppColor.darkColor))
    ]));
  }
}
