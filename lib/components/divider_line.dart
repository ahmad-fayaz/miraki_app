import 'package:flutter/material.dart';
import 'package:miraki_app/constants/style.dart';

class SliverDividerLine extends StatelessWidget {
  final double height;
  const SliverDividerLine({Key? key, this.height = 40.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Divider(
        height: height,
        color: AppColor.lightGrey.withOpacity(.2),
        thickness: 5.0,
      ),
    );
  }
}

class DividerLine extends StatelessWidget {
  final double height;
  const DividerLine({Key? key, this.height = 40.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      color: AppColor.lightGrey.withOpacity(.2),
      thickness: 5.0,
    );
  }
}
