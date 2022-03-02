import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:miraki_app/arguments/product_detail_argument.dart';
import 'package:miraki_app/components/loading_bar.dart';
import 'package:miraki_app/constants/services.dart';
import 'package:miraki_app/models/product_model.dart';
import 'package:miraki_app/router/router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Miraki'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteGenerator.cartRoute);
              },
              icon: Icon(Icons.list))
        ],
      ),
      body: SafeArea(
        child: StreamBuilder(
            stream: firestoreService.productsRef.snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Product>> snapshot) {
              if (snapshot.hasError) {
                return const LoadingBar();
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingBar();
              }
              final data = snapshot.data;
              return DataTable(
                columns: [
                  DataColumn(label: Text('Product name')),
                  DataColumn(label: Text('Price')),
                ],
                rows: [
                  ...data!.docs.map((e) => DataRow(
                          onSelectChanged: (value) {
                            Navigator.pushNamed(
                                context, RouteGenerator.detailRoute,
                                arguments: ProductDetailArguments(productId: e.id));
                          },
                          cells: [
                            DataCell(Text(e.data().productName)),
                            DataCell(Text('${e.data().mainPrice}')),
                          ]))
                ],
              );
            }),
      ),
    );
  }
}
