class Brand {
  String id;
  final String mainCategoryName;
  final String mainCategoryId;
  final String subCategoryName;
  final String subCategoryId;
  final String className;
  final String classId;
  final String brandName;
  final String brandLogo;

  Brand(
      {required this.subCategoryName,
      required this.subCategoryId,
      required this.mainCategoryName,
      required this.mainCategoryId,
      required this.className,
      required this.classId,
      required this.brandName,
      required this.brandLogo,
      this.id = ''});

  Brand.fromJson(Map<String, Object?> json)
      : this(
          mainCategoryName: json['mainCategoryName']! as String,
          mainCategoryId: json['mainCategoryId']! as String,
          subCategoryName: json['subCategoryName']! as String,
          subCategoryId: json['subCategoryId']! as String,
          className: json['className']! as String,
          classId: json['classId']! as String,
          brandName: json['brandName']! as String,
          brandLogo: json['brandLogo']! as String,
        );

  Map<String, Object?> toJson() => {
        'subCategoryName': subCategoryName,
        'subCategoryId': subCategoryId,
        'mainCategoryName': mainCategoryName,
        'mainCategoryId': mainCategoryId,
        'className': className,
        'classId': classId,
        'brandName': brandName,
        'brandLogo': brandLogo,
      };
}
