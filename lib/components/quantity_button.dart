import 'package:flutter/material.dart';
import 'package:miraki_app/constants/style.dart';

class QuantityButton extends StatelessWidget {
  final int quantity;
  final Function(int) onIncriment;
  final Function(int) onDecriment;
  const QuantityButton(
      {Key? key,
      required this.quantity,
      required this.onIncriment,
      required this.onDecriment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const _height = 35.0;
    const _width = 120.0;
    int _quantity = quantity;
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColor.lightGrey),
          borderRadius: BorderRadius.circular(4.0)),
      height: _height,
      width: _width,
      child: Row(
        children: [
          Expanded(
              flex: 5,
              child: Ink(
                  height: _height,
                  child: InkWell(
                      onTap: () {
                        onDecriment(_quantity -= 1);
                      },
                      child: _quantity <= 1
                          ? const Icon(Icons.delete)
                          : const Icon(Icons.remove)))),
          Expanded(
              flex: 6,
              child: Container(
                height: _height,
                color: AppColor.primaryColor.withOpacity(.3),
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      '$_quantity',
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16.0),
                    )),
              )),
          Expanded(
              flex: 5,
              child: Ink(
                  height: _height,
                  child: InkWell(
                      onTap: () {
                        onIncriment(_quantity += 1);
                      },
                      child: const Icon(Icons.add)))),
        ],
      ),
    );
  }
}
