import 'package:miraki_app/models/order_payment_model.dart';
import 'package:miraki_app/models/order_product_model.dart';
import 'package:miraki_app/models/order_user_model.dart';

class Order {
  late String id;
  final int quantity;
  final OrderProduct product;
  final OrderPayment payment;
  final OrderUser user;
  final bool isNew;
  final int placedTime;

  Order(
      {required this.payment,
      required this.product,
      required this.user,
      required this.quantity,
      this.isNew = true,
      required this.placedTime});

  Order.fromJson(Map<String, Object?> json)
      : this(
          quantity: json['quantity']! as int,
          product:
              OrderProduct.fromJson(json['product']! as Map<String, Object?>),
          payment:
              OrderPayment.fromJson(json['payment']! as Map<String, Object?>),
          user: OrderUser.fromJson(json['user']! as Map<String, Object?>),
          isNew: json['isNew']! as bool,
          placedTime: json['placedTime']! as int,
        );

  Map<String, Object?> toJson() => {
        'quantity': quantity,
        'product': product.toJson(),
        'payment': payment.toJson(),
        'user': user.toJson(),
        'isNew': isNew,
        'placedTime': placedTime
      };
}
