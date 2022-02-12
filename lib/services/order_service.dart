import 'package:miraki_app/constants/services.dart';
import 'package:miraki_app/models/order_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:miraki_app/models/varient_detail_model.dart';

class OrderService {
  static Future<DocumentReference<Order>>  placeNewOrder({
    required String productName,
    required String productImage,
    required String colorName,
    required String colorCode,
    required List<VarientDetail> varients,
    required double mainPrice,
    required double offerPrice,
    required int quantity,
  }) {
    Order order = Order(
        productName: productName,
        productImage: productImage,
        colorName: colorName,
        colorCode: colorCode,
        varients: varients,
        mainPrice: mainPrice,
        offerPrice: offerPrice,
        quantity: quantity);

    return firestoreService.ordersRef.add(order);
  }
}
