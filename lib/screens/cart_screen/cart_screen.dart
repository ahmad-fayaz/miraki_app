import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:miraki_app/components/divider_line.dart';
import 'package:miraki_app/components/loading_bar.dart';
import 'package:miraki_app/components/product_action_button.dart';
import 'package:miraki_app/constants/dimensions.dart';
import 'package:miraki_app/constants/services.dart';
import 'package:miraki_app/constants/style.dart';
import 'package:miraki_app/models/cart_model.dart';
import 'package:miraki_app/screens/cart_screen/widgets/cart_card.dart';
import 'package:miraki_app/services/cart_service.dart';
import 'package:miraki_app/services/currency_service.dart';
import 'package:sliver_tools/sliver_tools.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              title: Text('Your Cart'),
              elevation: 0.0,
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(16.0).copyWith(bottom: 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StreamBuilder<double>(
                        stream: CartService.totalPrice,
                        builder: (BuildContext context,
                            AsyncSnapshot<double> snapshot) {
                          if (snapshot.hasError) {
                            return const LoadingBar();
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const LoadingBar();
                          }
                          return RichText(
                            text: TextSpan(children: [
                              const TextSpan(
                                text: 'Subtotal: ',
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.darkColor),
                              ),
                              TextSpan(
                                text: getIndianCurrency(snapshot.data!),
                                style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.darkColor),
                              ),
                            ]),
                          );
                        }),
                    spaceOf10,
                    Row(
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: AppColor.secondaryColor,
                        ),
                        spaceOf8Horizaontal,
                        const Text(
                          'FREE Scheduled Delivery',
                          style: TextStyle(
                              color: AppColor.secondaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.0),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SliverPinnedHeader(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: StreamBuilder<int>(
                    stream: CartService.totalItems,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const LoadingBar();
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const LoadingBar();
                      }
                      return ProductActionButton(
                        label: 'Proceed to By (${snapshot.data})',
                        color: AppColor.primaryColor,
                        onTap: () {},
                      );
                    }),
              ),
            ),
            StreamBuilder<QuerySnapshot<Cart>>(
                stream: firestoreService.cartRef.snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Cart>> snapshot) {
                  if (snapshot.hasError) {
                    return const SliverToBoxAdapter(child: LoadingBar());
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SliverToBoxAdapter(child: LoadingBar());
                  }

                  final data = snapshot.data;
                  return SliverList(
                      delegate: SliverChildBuilderDelegate(((context, index) {
                    final cart = data!.docs[index].data();
                    cart.cartId = data.docs[index].id;
                    return Column(
                      children: [
                        CartCard(cart: cart),
                        const DividerLine(
                          height: 15.0,
                        )
                      ],
                    );
                  }), childCount: data!.size));
                })
          ],
        ),
      ),
    );
  }
}
