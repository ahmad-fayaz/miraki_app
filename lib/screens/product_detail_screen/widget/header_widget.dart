import 'package:flutter/material.dart';
import 'package:miraki_app/constants/dimensions.dart';
import 'package:miraki_app/constants/style.dart';
import 'package:miraki_app/models/color_model.dart';
import 'package:miraki_app/models/product_model.dart';

class HeaderWidget extends StatefulWidget {
  final ColorModel colorModel;
  final Product product;
  const HeaderWidget(
      {Key? key, required this.colorModel, required this.product})
      : super(key: key);

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  final _pageViewController = PageController(initialPage: 999);
  int _selectedImage = 0;

  @override
  void initState() {
    _pageViewController.addListener(() {
      setState(() => _selectedImage = _pageViewController.page!.toInt() %
          widget.colorModel.subImages.length);
    });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant HeaderWidget oldWidget) {
    _selectedImage = 0;
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              widget.product.productName,
              style: const TextStyle(
                  height: 1.4, fontSize: 16.0, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        SizedBox(
          height: 200.0,
          child: PageView.builder(
            controller: _pageViewController,
            itemBuilder: (context, index) => HeaderImage(
                imageUrl: widget.colorModel
                    .subImages[index % widget.colorModel.subImages.length]),
          ),
        ),
        spaceOf16,
        SizedBox(
            height: 50.0,
            child: HeaderImageList(
              imageList: widget.colorModel.subImages.map((e) => '$e').toList(),
              selectedImage: _selectedImage,
              onSelect: (index) {
                _pageViewController.animateToPage(index,
                    duration: const Duration(microseconds: 1000),
                    curve: Curves.easeIn);
              },
            ))
      ],
    );
  }
}

class HeaderImage extends StatelessWidget {
  final String imageUrl;
  const HeaderImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(imageUrl);
  }
}

class HeaderImageList extends StatelessWidget {
  final int selectedImage;
  final List<String> imageList;
  final Function(int) onSelect;
  const HeaderImageList(
      {Key? key,
      required this.imageList,
      required this.selectedImage,
      required this.onSelect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...imageList
              .asMap()
              .map((index, value) => MapEntry(
                  index,
                  ImageListCard(
                      onSelect: () {
                        onSelect(index);
                      },
                      imageUrl: value,
                      isSelected: selectedImage == index)))
              .values
              .toList()
        ],
      ),
    );
  }
}

class ImageListCard extends StatefulWidget {
  final String imageUrl;
  final bool isSelected;
  final Function() onSelect;
  const ImageListCard(
      {Key? key,
      required this.imageUrl,
      required this.isSelected,
      required this.onSelect})
      : super(key: key);

  @override
  State<ImageListCard> createState() => _ImageListCardState();
}

class _ImageListCardState extends State<ImageListCard> {
  bool _pressed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) => setState(() => _pressed = true),
      onTapUp: (details) => setState(() {
        _pressed = false;
        widget.onSelect();
      }),
      onTapCancel: () => setState(() => _pressed = false),
      child: Container(
        margin: const EdgeInsets.only(right: 10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            color: AppColor.light,
            border: Border.all(
                color: widget.isSelected || _pressed
                    ? AppColor.primaryColor
                    : AppColor.lightGrey),
            boxShadow: widget.isSelected && !_pressed
                ? [
                    const BoxShadow(
                        color: AppColor.primaryColor,
                        blurRadius: 4.0,
                        offset: Offset(1.0, 1.0))
                  ]
                : null),
        padding: const EdgeInsets.all(5.0),
        height: 48.0,
        width: 48.0,
        child: Image.network(widget.imageUrl),
      ),
    );
  }
}
