import 'package:flutter/material.dart';
import 'package:miraki_app/constants/style.dart';
import 'package:miraki_app/services/currency_service.dart';

class MRPPrice extends StatelessWidget {
  final double price;
  const MRPPrice({Key? key, required this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
        text: 'M.R.P.: ',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: AppColor.darkColor.withOpacity(.5),
        ),
      ),
      TextSpan(
        text: getIndianCurrency(price),
        style: TextStyle(
            fontWeight: FontWeight.w500,
            color: AppColor.darkColor.withOpacity(.5),
            decoration: TextDecoration.lineThrough),
      ),
    ]));
  }
}
