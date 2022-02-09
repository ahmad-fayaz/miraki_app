import 'package:flutter/material.dart';
import 'package:miraki_app/screens/product_detail_screen/product_detail_screen.dart';

class RouteGenerator {
  static const detailRoute = '/detail';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case detailRoute:
        if (args.runtimeType == String) {
          return MaterialPageRoute(
              builder: (_) => ProductDetailScreen(productId: args as String));
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
