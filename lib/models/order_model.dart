import 'package:miraki_app/models/varient_detail_model.dart';

class Order {
  final String productName;
  final String productImage;
  final String colorName;
  final String colorCode;
  final List<VarientDetail> varients;
  final double mainPrice;
  final double offerPrice;
  final int quantity;
  final String userName;
  final Map<String, String> address;

  Order(
      {required this.productName,
      required this.productImage,
      required this.colorName,
      required this.colorCode,
      required this.varients,
      required this.mainPrice,
      required this.offerPrice,
      required this.quantity,
      this.userName = 'Nabeel Ahmad',
      this.address = const {'city': 'Mangalore', 'pincode': '574231'}});

  Order.fromJson(Map<String, Object?> json)
      : this(
            productName: json['productName']! as String,
            productImage: json['productImage']! as String,
            colorName: json['colorName']! as String,
            colorCode: json['colorCode']! as String,
            varients: (json['varients']! as List<dynamic>)
                .map((e) => VarientDetail.fromJson(e))
                .toList(),
            mainPrice: json['mainPrice']! as double,
            offerPrice: json['offerPrice']! as double,
            quantity: json['quantity']! as int,
            userName: json['userName']! as String,
            address: json['address']! as Map<String, String>);

  Map<String, Object?> toJson() => {
        'productName': productName,
        'productImage': productImage,
        'colorName': colorName,
        'colorCode': colorCode,
        'varients': varients.map((e) => e.toJson()).toList(),
        'mainPrice': mainPrice,
        'offerPrice': offerPrice,
        'quantity': quantity,
        'userName': userName,
        'address': address,
      };
}
