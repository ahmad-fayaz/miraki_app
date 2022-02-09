class Product {
  late String productId;
  final String mainCategoryId;
  final String mainCategoryName;
  final String subCategoryId;
  final String subCategoryName;
  final String classId;
  final String className;
  final String brandId;
  final String brandName;
  final String capacity;
  final String model;
  final String mainImage;
  final String productName;
  final String productDescription;
  final num mainPrice;
  final num mainOff;
  final num refundDays;
  final int gstPercent;
  final List<dynamic> specifications;

  Product(
      {
      required this.mainCategoryId,
      required this.mainCategoryName,
      required this.subCategoryId,
      required this.subCategoryName,
      required this.classId,
      required this.className,
      required this.brandId,
      required this.brandName,
      required this.capacity,
      required this.model,
      required this.mainImage,
      required this.productName,
      required this.productDescription,
      required this.mainPrice,
      required this.mainOff,
      required this.refundDays,
      required this.gstPercent,
      required this.specifications});

  Product.fromJson(Map<String, Object?> json)
      : this(
            mainCategoryId: json['mainCategoryId']! as String,
            mainCategoryName: json['mainCategoryName']! as String,
            subCategoryId: json['subCategoryId']! as String,
            subCategoryName: json['subCategoryName']! as String,
            classId: json['classId']! as String,
            className: json['className']! as String,
            brandId: json['brandId']! as String,
            brandName: json['brandName']! as String,
            capacity: json['capacity']! as String,
            model: json['model']! as String,
            mainImage: json['mainImage']! as String,
            productName: json['productName']! as String,
            productDescription: json['productDescription']! as String,
            mainPrice: json['mainPrice']! as num,
            mainOff: json['mainOff']! as num,
            refundDays: json['refundDays']! as num,
            gstPercent: json['gstPercent']! as int,
            specifications: json['specifications']! as List<dynamic>);

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
      'capacity': capacity,
      'model': model,
      'mainImage': mainImage,
      'productName': productName,
      'productDescription': productDescription,
      'mainPrice': mainPrice,
      'mainOff': mainOff,
      'refundDays': refundDays,
      'gstPercent': gstPercent,
      'specifications': specifications,
    };
  }

  setProductId(String productId) {
    this.productId = productId;
  }
}

// List<Product> productList = [
//   Product(
//     imageLink: 'jhewdfjwehdf',
//     title: 'Adipoli Chair',
//     desc: 'With 4 legs',
//     amount: 20,
//   ),
//   Product(
//       imageLink: 'jhewdfjwehdf',
//       title: 'Fayaz chair',
//       desc: 'With 4 legs',
//       amount: 20,
//   ),
//   Product(
//       imageLink: 'jhewdfjwehdf',
//       title: 'Adipoli Chair',
//       desc: 'With 4 legs',
//       amount: 20,
//   ),
//   Product(
//       imageLink: 'jhewdfjwehdf',
//       title: 'alnaaf Chair',
//       desc: 'With 4 legs',
//       amount: 20,
//   ),
//   Product(
//       imageLink: 'jhewdfjwehdf',
//       title: 'Adipoli Chair',
//       desc: 'With 4 legs',
//       amount: 20,
//   ),
//   Product(
//       imageLink: 'jhewdfjwehdf',
//       title: 'Fayaz chair',
//       desc: 'With 4 legs',
//       amount: 20,
//   ),
//   Product(
//       imageLink: 'jhewdfjwehdf',
//       title: 'Adipoli Chair',
//       desc: 'With 4 legs',
//       amount: 20,
//   ),
//   Product(
//       imageLink: 'jhewdfjwehdf',
//       title: 'alnaaf Chair',
//       desc: 'With 4 legs',
//       amount: 20,
//   ),
// ];