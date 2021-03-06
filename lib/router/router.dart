import 'package:flutter/material.dart';
import 'package:miraki_app/arguments/product_detail_argument.dart';
import 'package:miraki_app/screens/cart_screen/cart_screen.dart';
import 'package:miraki_app/screens/product_detail_screen/product_detail_screen.dart';

class RouteGenerator {
  static const cartRoute = '/cart';
  static const detailRoute = '/detail';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case cartRoute:
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case detailRoute:
        if (args.runtimeType == ProductDetailArguments) {
          return MaterialPageRoute(
              builder: (_) => ProductDetailScreen(arguments: args as ProductDetailArguments));
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(child: Text('Error')),
      );
    });
  }
}
