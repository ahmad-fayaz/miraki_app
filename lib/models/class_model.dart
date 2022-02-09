class Class {
  String id;
  final String mainCategoryName;
  final String mainCategoryId;
  final String subCategoryName;
  final String subCategoryId;
  final String className;
  final String mainOfferImage;
  final List<dynamic> sideOfferImageList;

  Class(
      {required this.subCategoryName,
      required this.subCategoryId,
      required this.mainCategoryName,
      required this.mainCategoryId,
      required this.className,
      required this.mainOfferImage,
      required this.sideOfferImageList,
      this.id = ''});

  Class.fromJson(Map<String, Object?> json)
      : this(
            mainCategoryName: json['mainCategoryName']! as String,
            mainCategoryId: json['mainCategoryId']! as String,
            subCategoryName: json['subCategoryName']! as String,
            subCategoryId: json['subCategoryId']! as String,
            className: json['className']! as String,
            mainOfferImage: json['mainOffer']! as String,
            sideOfferImageList: json['sideOffers']! as List<dynamic>);

  Map<String, Object?> toJson() => {
        'subCategoryName': subCategoryName,
        'subCategoryId': subCategoryId,
        'mainCategoryName': mainCategoryName,
        'mainCategoryId': mainCategoryId,
        'className': className,
        'mainOffer': mainOfferImage,
        'sideOffers': sideOfferImageList
      };
}
