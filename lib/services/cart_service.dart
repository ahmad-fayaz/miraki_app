import 'package:miraki_app/constants/services.dart';
import 'package:miraki_app/models/cart_model.dart';
import 'package:miraki_app/models/varient_detail_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:miraki_app/services/price_service.dart';

class CartService {
  static Future<void> addToCart(
      {required String mainCategoryId,
      required String mainCategoryName,
      required String subCategoryId,
      required String subCategoryName,
      required String classId,
      required String className,
      required String brandId,
      required String brandName,
      required String mainImage,
      required String productId,
      required String productName,
      required String productDescription,
      required String colorName,
      required String colorCode,
      required num price,
      required num offer,
      required int refundDays,
      required int gstPercent,
      required int mirakiPercent,
      required List<String> varients,
      int quantity = 1}) {
    String _varients = '';
    for (var varient in varients) {
      _varients += '$varient,';
    }
    final cart = Cart(
        mainCategoryId: mainCategoryId,
        mainCategoryName: mainCategoryName,
        subCategoryId: subCategoryId,
        subCategoryName: subCategoryName,
        classId: classId,
        className: className,
        brandId: brandId,
        brandName: brandName,
        mainImage: mainImage,
        productId: productId,
        productName: productName,
        productDescription: productDescription,
        colorName: colorName,
        colorCode: colorCode,
        price: price,
        offer: offer,
        refundDays: refundDays,
        gstPercent: gstPercent,
        mirakiPercent: mirakiPercent,
        varients: _varients,
        quantity: quantity);

    return firestoreService.cartRef.doc().set(cart);
  }

  static Future<Cart?> isExistInCart(
      {required String productId,
      required String colorName,
      required List<VarientDetail> varients}) async {
    String _varients = '';
    for (var varient in varients) {
      _varients += '${varient.varientName}: ${varient.valueName},';
    }
    late QuerySnapshot<Cart> cartList;

    if (varients.isEmpty) {
      cartList = await firestoreService.cartRef
          .where('productId', isEqualTo: productId)
          .where('colorName', isEqualTo: colorName)
          .get();
    } else {
      cartList = await firestoreService.cartRef
          .where('productId', isEqualTo: productId)
          .where('colorName', isEqualTo: colorName)
          .where('varients', isEqualTo: _varients)
          .get();
    }

    if (cartList.docs.isEmpty) {
      return null;
    }
    final cart = cartList.docs.first.data();
    cart.cartId = cartList.docs.first.id;
    return cart;
  }

  static Future<void> updateQuantity(String cartId, int quantity) {
    if (quantity >= 1) {
      return firestoreService.cartRef
          .doc(cartId)
          .update({'quantity': quantity});
    }
    return firestoreService.cartRef.doc(cartId).delete();
  }

  static Stream<double> get totalPrice {
    final _cartSapshot = firestoreService.cartRef.snapshots();
    return _cartSapshot.map((event) {
      double totalPrice = 0;
      for (var doc in event.docs) {
        final cart = doc.data();
        final price =
            PriceService.calculate(price: cart.price, offer: cart.offer)
                    .offerPrice *
                cart.quantity;
        totalPrice += price;
      }
      return totalPrice;
    });
  }

  static Stream<int> get totalItems {
    final _cartSapshot = firestoreService.cartRef.snapshots();
    return _cartSapshot.map((event) {
      return event.size;
    });
  }
}
