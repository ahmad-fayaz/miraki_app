class Cart {
  late String cartId;
  final String mainCategoryId;
  final String mainCategoryName;
  final String subCategoryId;
  final String subCategoryName;
  final String classId;
  final String className;
  final String brandId;
  final String brandName;
  final String mainImage;
  final String productId;
  final String productName;
  final String productDescription;
  final String colorName;
  final String colorCode;
  final num price;
  final num offer;
  final num refundDays;
  final int gstPercent;
  final int mirakiPercent;
  final String varients;
  final int quantity;

  Cart(
      {required this.mainCategoryId,
      required this.mainCategoryName,
      required this.subCategoryId,
      required this.subCategoryName,
      required this.classId,
      required this.className,
      required this.brandId,
      required this.brandName,
      required this.mainImage,
      required this.productId,
      required this.productName,
      required this.productDescription,
      required this.colorName,
      required this.colorCode,
      required this.price,
      required this.offer,
      required this.refundDays,
      required this.gstPercent,
      required this.mirakiPercent,
      required this.varients,
      required this.quantity});

  Cart.fromJson(Map<String, Object?> json)
      : this(
            mainCategoryId: json['mainCategoryId']! as String,
            mainCategoryName: json['mainCategoryName']! as String,
            subCategoryId: json['subCategoryId']! as String,
            subCategoryName: json['subCategoryName']! as String,
            classId: json['classId']! as String,
            className: json['className']! as String,
            brandId: json['brandId']! as String,
            brandName: json['brandName']! as String,
            mainImage: json['mainImage']! as String,
            productId: json['productId']! as String,
            productName: json['productName']! as String,
            productDescription: json['productDescription']! as String,
            colorName: json['colorName']! as String,
            colorCode: json['colorCode']! as String,
            price: json['price']! as num,
            offer: json['offer']! as num,
            refundDays: json['refundDays']! as num,
            gstPercent: json['gstPercent']! as int,
            mirakiPercent: json['mirakiPercent']! as int,
            varients: json['varients']! as String,
            quantity: json['quantity']! as int);

  Map<String, Object?> toJson() {
    return {
      'mainCategoryId': mainCategoryId,
      'mainCategoryName': mainCategoryName,
      'subCategoryId': subCategoryId,
      'subCategoryName': subCategoryName,
      'classId': classId,
      'className': className,
      'brandId': brandId,
      'brandName': brandName,
      'mainImage': mainImage,
      'productName': productName,
      'productId': productId,
      'productDescription': productDescription,
      'colorName': colorName,
      'colorCode': colorCode,
      'price': price,
      'offer': offer,
      'refundDays': refundDays,
      'gstPercent': gstPercent,
      'mirakiPercent': mirakiPercent,
      'varients': varients,
      'quantity': quantity,
    };
  }
}
