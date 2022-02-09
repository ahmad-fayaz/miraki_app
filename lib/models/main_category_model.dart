class MainCategory {
  String id;
  final String mainCategoryName;

  MainCategory({required this.mainCategoryName, this.id = ''});

  MainCategory.fromJson(Map<String, Object?> json)
      : this(mainCategoryName: json['mainCategoryName']! as String);

  Map<String, Object?> toJson() => {
    'mainCategoryName': mainCategoryName
  };
}
