import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingBar extends StatelessWidget {
  final double size;
  final Color color;

  const LoadingBar(
      {this.size = 25.0, this.color = Colors.orangeAccent, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: CircularProgressIndicator(
          color: color,
        ),
      ),
    );
  }
}
