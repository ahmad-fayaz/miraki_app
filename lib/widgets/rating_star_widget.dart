import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:miraki_app/constants/style.dart';

class RatingStar extends StatelessWidget {
  final double itemSize;
  const RatingStar({Key? key, this.itemSize = 40.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
        itemSize: itemSize,
        initialRating: 4.5,
        itemCount: 5,
        ignoreGestures: true,
        allowHalfRating: true,
        unratedColor: AppColor.primaryColorLight.withOpacity(.8),
        itemBuilder: (context, index) => const Icon(
              Icons.star,
              color: AppColor.primaryColor,
            ),
        onRatingUpdate: (value) {
          print(value);
        });
  }
}
