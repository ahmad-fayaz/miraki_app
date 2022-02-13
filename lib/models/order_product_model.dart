class OrderProduct {
  final String productId;
  final String mainCategoryName;
  final String subCategoryName;
  final String className;
  final String brandName;
  final String capacity;
  final String model;
  final String productImage;
  final String productName;
  final String productDescription;
  final String colorName;
  final String colorCode;
  final List<dynamic> varients;

  OrderProduct({
    required this.productId,
    required this.mainCategoryName,
    required this.subCategoryName,
    required this.className,
    required this.brandName,
    required this.capacity,
    required this.model,
    required this.productImage,
    required this.productName,
    required this.productDescription,
    required this.colorName,
    required this.colorCode,
    required this.varients,
  });

  OrderProduct.fromJson(Map<String, Object?> json)
      : this(
          productId: json['productId']! as String,
          mainCategoryName: json['mainCategoryName']! as String,
          subCategoryName: json['subCategoryName']! as String,
          className: json['className']! as String,
          brandName: json['brandName']! as String,
          capacity: json['capacity']! as String,
          model: json['model']! as String,
          productImage: json['productImage']! as String,
          productName: json['productName']! as String,
          productDescription: json['productDescription']! as String,
          colorName: json['colorName']! as String,
          colorCode: json['colorCode']! as String,
          varients: json['varients']! as List<dynamic>,
        );

  Map<String, Object?> toJson() {
    return {
      'productId': productId,
      'mainCategoryName': mainCategoryName,
      'subCategoryName': subCategoryName,
      'className': className,
      'brandName': brandName,
      'capacity': capacity,
      'model': model,
      'productImage': productImage,
      'productName': productName,
      'productDescription': productDescription,
      'colorName': colorName,
      'colorCode': colorCode,
      'varients': varients,
    };
  }
}
