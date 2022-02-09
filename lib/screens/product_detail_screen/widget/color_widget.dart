import 'package:flutter/material.dart';
import 'package:miraki_app/constants/dimensions.dart';
import 'package:miraki_app/constants/style.dart';
import 'package:miraki_app/models/color_model.dart';

class ColorWidget extends StatelessWidget {
  final List<ColorModel> colorList;
  final ColorModel selectedColor;
  final Function(ColorModel) onSelected;
  const ColorWidget(
      {Key? key,
      required this.colorList,
      required this.selectedColor,
      required this.onSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(children: [
          const TextSpan(
              text: 'Color name: ',
              style: TextStyle(color: AppColor.darkColor)),
          TextSpan(
              text: selectedColor.colorName,
              style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                  color: AppColor.darkColor))
        ])),
        spaceOf10,
        SizedBox(
          height: 150.0,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: colorList.length,
              itemBuilder: (context, index) {
                return ColorImageCard(
                  imageUrl: colorList[index].subImages.first,
                  colorName: colorList[index].colorName,
                  isSelectedColor: colorList[index] == selectedColor,
                  onTap: () {
                    onSelected(colorList[index]);
                  },
                );
              }),
        ),
      ],
    );
  }
}

class ColorImageCard extends StatelessWidget {
  final String imageUrl;
  final String colorName;
  final bool isSelectedColor;
  final Function() onTap;
  const ColorImageCard(
      {Key? key,
      required this.imageUrl,
      required this.colorName,
      this.isSelectedColor = false,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: const EdgeInsets.only(right: 16.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
                color: isSelectedColor
                    ? AppColor.primaryColor
                    : AppColor.lightGrey)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0)),
                    child: Image.network(
                      imageUrl,
                      height: 100.0,
                      width: 100.0,
                    ),
                  ),
                ),
                Positioned.fill(
                    child: Container(
                  color: isSelectedColor
                      ? AppColor.primaryColor.withOpacity(.06)
                      : AppColor.lightGrey.withOpacity(.06),
                ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(colorName,
                  style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      color: AppColor.darkColor)),
            )
          ],
        ),
      ),
    );
  }
}
