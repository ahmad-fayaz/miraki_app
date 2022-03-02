import 'package:flutter/material.dart';
import 'package:miraki_app/arguments/product_detail_argument.dart';
import 'package:miraki_app/components/label_text.dart';
import 'package:miraki_app/components/mrp_price.dart';
import 'package:miraki_app/components/quantity_button.dart';
import 'package:miraki_app/constants/dimensions.dart';
import 'package:miraki_app/constants/style.dart';
import 'package:miraki_app/models/cart_model.dart';
import 'package:miraki_app/router/router.dart';
import 'package:miraki_app/services/cart_service.dart';
import 'package:miraki_app/services/currency_service.dart';
import 'package:miraki_app/services/price_service.dart';

class CartCard extends StatelessWidget {
  final Cart cart;
  const CartCard({Key? key, required this.cart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              List<String> varientValues = cart.varients.split(',');
              varientValues.remove(varientValues.last);
              varientValues =
                  varientValues.map((e) => e.split(': ')[1]).toList();
              Navigator.pushNamed(context, RouteGenerator.detailRoute,
                  arguments: ProductDetailArguments(
                      productId: cart.productId,
                      selectedColorName: cart.colorName,
                      selectedVarientValues:
                          varientValues.isNotEmpty ? varientValues : null));
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 25,
                    child: Image.network(
                      cart.mainImage,
                      height: 100.0,
                    )),
                spaceOf10Horizaontal,
                Expanded(
                    flex: 75,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cart.productName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              height: 1.4,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600),
                        ),
                        spaceOf10,
                        Text(
                          getIndianCurrency(PriceService.calculate(
                                  price: cart.price, offer: cart.offer)
                              .offerPrice
                              .toDouble()),
                          style: const TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w600),
                        ),
                        spaceOf8,
                        MRPPrice(price: cart.price.toDouble()),
                        spaceOf8,
                        const Text(
                          'Free Scheduled Delivery',
                        ),
                        spaceOf16,
                        const Text(
                          'In Stock',
                          style: TextStyle(color: AppColor.secondaryColor),
                        ),
                        ...cart.varients.split(',').map((varient) {
                          if (varient.isNotEmpty) {
                            final _varient = varient.split(': ');
                            final _varientName = _varient[0];
                            final _varientValue = _varient[1];
                            return Column(
                              children: [
                                spaceOf10,
                                LabelText(
                                    label: _varientName, value: _varientValue),
                              ],
                            );
                          }
                          return const SizedBox.shrink();
                        })
                      ],
                    ))
              ],
            ),
          ),
          spaceOf10,
          Row(
            children: [
              QuantityButton(
                quantity: cart.quantity,
                onIncriment: (value) async =>
                    await CartService.updateQuantity(cart.cartId, value),
                onDecriment: (value) async =>
                    await CartService.updateQuantity(cart.cartId, value),
              ),
              spaceOf10Horizaontal,
              MaterialButton(
                height: 35.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0)),
                onPressed: () {},
                color: AppColor.secondaryColor,
                elevation: 0.0,
                focusElevation: 0.0,
                highlightElevation: 0.0,
                child: Row(
                  children: const [
                    Icon(
                      Icons.favorite_border,
                      size: 20.0,
                      color: AppColor.light,
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: AppColor.light,
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
