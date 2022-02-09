class SubCategory {
  String id;
  final String mainCategoryName;
  final String mainCategoryId;
  final String subCategoryName;
  final String subCategoryImage;

  SubCategory(
      {required this.mainCategoryName,
      required this.mainCategoryId,
      required this.subCategoryName,
      required this.subCategoryImage,
      this.id = ''});

  SubCategory.fromJson(Map<String, Object?> json)
      : this(
            mainCategoryName: json['mainCategoryName']! as String,
            mainCategoryId: json['mainCategoryId']! as String,
            subCategoryName: json['subCategoryName']! as String,
            subCategoryImage: json['subCategoryImage']! as String);

  Map<String, Object?> toJson() => {
        'mainCategoryName': mainCategoryName,
        'mainCategoryId': mainCategoryId,
        'subCategoryName': subCategoryName,
        'subCategoryImage': subCategoryImage
      };
}
