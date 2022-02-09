class ColorModel {
  final String colorName;
  final String colorCode;
  final num colorPriceChange;
  final int colorOfferChange;
  final bool isDefaultColor;
  final List<dynamic> subImages;

  ColorModel(
      {required this.colorName,
      required this.colorCode,
      required this.colorPriceChange,
      required this.colorOfferChange,
      this.isDefaultColor = false,
      required this.subImages});

  ColorModel.fromJson(Map<String, Object?> json)
      : this(
            colorName: json['colorName']! as String,
            colorCode: json['colorCode']! as String,
            colorPriceChange: json['colorPriceChange']! as num,
            colorOfferChange: json['colorOfferChange']! as int,
            isDefaultColor: json['isDefaultColor']! as bool,
            subImages: json['subImages']! as List<dynamic>);

  Map<String, Object?> toJson() => {
        'colorName': colorName,
        'colorCode': colorCode,
        'colorPriceChange': colorPriceChange,
        'colorOfferChange': colorOfferChange,
        'isDefaultColor': isDefaultColor,
        'subImages': subImages,
      };
}
