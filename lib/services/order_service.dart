import 'package:miraki_app/constants/constants.dart';
import 'package:miraki_app/constants/services.dart';
import 'package:miraki_app/models/order_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:miraki_app/models/order_payment_model.dart';
import 'package:miraki_app/models/order_product_model.dart';
import 'package:miraki_app/models/order_user_model.dart';

class OrderService {
  static Future<DocumentReference<Order>> placeNewOrder(
      {required String productId,
      required String mainCategoryName,
      required String subCategoryName,
      required String className,
      required String brandName,
      required String capacity,
      required String model,
      required String productImage,
      required String productName,
      required String productDescription,
      required String colorName,
      required String colorCode,
      required List<String> varients,
      required bool isOnlinePayment,
      required num mainPrice,
      required num offerPrice,
      required num refundDays,
      required int gstPercent,
      required int quantity}) {
    final product = OrderProduct(
        productId: productId,
        mainCategoryName: mainCategoryName,
        subCategoryName: subCategoryName,
        className: className,
        brandName: brandName,
        capacity: capacity,
        model: model,
        productImage: productImage,
        productName: productName,
        productDescription: productDescription,
        colorName: colorName,
        colorCode: colorCode,
        varients: varients);

    final payment = OrderPayment(
        isOnlinePayment: isOnlinePayment,
        mainPrice: mainPrice,
        offerPrice: offerPrice,
        refundDays: refundDays,
        gstPercent: gstPercent);

    final user = OrderUser(
        userId: 'userId',
        userName: 'Ahmad Fayaz',
        phone: '8197697717',
        address: 'Uddottu house, Sajipamunnur post and '
            'village, Bantwal taluq, DK - 574231',
        pinCode: '574231');

    final order = Order(
        payment: payment,
        product: product,
        user: user,
        quantity: quantity,
        placedTime: DateTime.now().millisecondsSinceEpoch, 
        orderStatus: OrderStatus.placed);

    return firestoreService.ordersRef.add(order);
  }
}
