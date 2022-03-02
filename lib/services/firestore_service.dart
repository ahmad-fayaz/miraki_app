import 'package:miraki_app/models/brand_model.dart';
import 'package:miraki_app/models/cart_model.dart';
import 'package:miraki_app/models/class_model.dart';
import 'package:miraki_app/models/color_model.dart';
import 'package:miraki_app/models/main_category_model.dart';
import 'package:miraki_app/models/order_model.dart';
import 'package:miraki_app/models/product_model.dart';
import 'package:miraki_app/models/sub_category_model.dart';
import 'package:miraki_app/models/varient_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  late FirebaseFirestore _firestore;
  FirestoreService() {
    _firestore = FirebaseFirestore.instance;
  }

  User? get currentUser => FirebaseAuth.instance.currentUser;
  String get currentUserId => currentUser == null ? 'sS5NJUusvmOKlJt731JgKnBPxPk1' : currentUser!.uid;

  WriteBatch get batch => FirebaseFirestore.instance.batch();

  CollectionReference<Brand> get brandRef =>
      _firestore.collection('brand').withConverter<Brand>(
          fromFirestore: (snapshot, _) => Brand.fromJson(snapshot.data()!),
          toFirestore: (brand, _) => brand.toJson());

  CollectionReference<Class> get classRef =>
      _firestore.collection('class').withConverter<Class>(
          fromFirestore: (snapshot, _) => Class.fromJson(snapshot.data()!),
          toFirestore: (class1, _) => class1.toJson());

  CollectionReference<Cart> get cartRef =>
      _firestore.collection('users/$currentUserId/cart').withConverter<Cart>(
          fromFirestore: (snapshot, _) => Cart.fromJson(snapshot.data()!),
          toFirestore: (cart, _) => cart.toJson());

  CollectionReference<ColorModel> getProductColorsRef(String productId) =>
      _firestore
          .collection('products/$productId/color')
          .withConverter<ColorModel>(
              fromFirestore: (snapshot, _) =>
                  ColorModel.fromJson(snapshot.data()!),
              toFirestore: (colorModel, _) => colorModel.toJson());

  CollectionReference<Varient> getProductVarientsRef(
          String productId) =>
      _firestore
          .collection('products/$productId/varient')
          .withConverter<Varient>(
              fromFirestore: (snapshot, _) =>
                  Varient.fromJson(snapshot.data()!),
              toFirestore: (varient, _) => varient.toJson());

  CollectionReference<MainCategory> get mainCategoryRef =>
      _firestore.collection('mainCategory').withConverter<MainCategory>(
          fromFirestore: (snapshot, _) =>
              MainCategory.fromJson(snapshot.data()!),
          toFirestore: (mainCategory, _) => mainCategory.toJson());

  CollectionReference<Order> get ordersRef =>
      _firestore.collection('orders').withConverter<Order>(
          fromFirestore: (snapshot, _) => Order.fromJson(snapshot.data()!),
          toFirestore: (order, _) => order.toJson());

  CollectionReference<Product> get productsRef =>
      _firestore.collection('products').withConverter<Product>(
          fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()!),
          toFirestore: (product, _) => product.toJson());

  CollectionReference<SubCategory> get subCategoryRef =>
      _firestore.collection('subCategory').withConverter<SubCategory>(
          fromFirestore: (snapshot, _) =>
              SubCategory.fromJson(snapshot.data()!),
          toFirestore: (subCategory, _) => subCategory.toJson());
}
