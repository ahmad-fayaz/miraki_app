import 'package:flutter/material.dart';
import 'package:miraki_app/components/loading_bar.dart';
import 'package:miraki_app/components/product_action_button.dart';
import 'package:miraki_app/constants/dimensions.dart';
import 'package:miraki_app/constants/services.dart';
import 'package:miraki_app/constants/style.dart';
import 'package:miraki_app/models/color_model.dart';
import 'package:miraki_app/models/product_model.dart';
import 'package:miraki_app/models/varient_detail_model.dart';
import 'package:miraki_app/models/varient_model.dart';
import 'package:miraki_app/screens/product_detail_screen/widget/color_widget.dart';
import 'package:miraki_app/screens/product_detail_screen/widget/header_widget.dart';
import 'package:miraki_app/screens/product_detail_screen/widget/varient_widget.dart';
import 'package:miraki_app/services/currency_service.dart';
import 'package:miraki_app/services/price_service.dart';
import 'package:miraki_app/widgets/rating_star_widget.dart';
import 'package:provider/provider.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productId;
  const ProductDetailScreen({Key? key, required this.productId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<DocumentSnapshot<Product>?>.value(
          initialData: null,
          value: firestoreService.productsRef.doc(productId).snapshots(),
        ),
        StreamProvider<QuerySnapshot<Varient>?>.value(
            value:
                firestoreService.getProductVarientsRef(productId).snapshots(),
            initialData: null),
        StreamProvider<QuerySnapshot<ColorModel>?>.value(
            value: firestoreService
                .getProductColorsRef(productId)
                .orderBy('isDefaultColor', descending: true)
                .snapshots(),
            initialData: null)
      ],
      builder: (context, child) {
        final _productSnapshot =
            Provider.of<DocumentSnapshot<Product>?>(context);
        final _colorListSnapshot =
            Provider.of<QuerySnapshot<ColorModel>?>(context);
        final _varientSnapshot = Provider.of<QuerySnapshot<Varient>?>(context);

        if (_productSnapshot == null ||
            _colorListSnapshot == null ||
            _varientSnapshot == null) {
          return const LoadingBar();
        }

        Product _product = _productSnapshot.data()!;
        _product.productId = _productSnapshot.id;
        final _colorList =
            _colorListSnapshot.docs.map((e) => e.data()).toList();
        final _varientList =
            _varientSnapshot.docs.map((element) => element.data()).toList();

        return ProductDetailContainer(
          product: _product,
          colorList: _colorList,
          varientList: _varientList,
        );
      },
    );
  }
}

class ProductDetailContainer extends StatefulWidget {
  final Product product;
  final List<ColorModel> colorList;
  final List<Varient> varientList;
  const ProductDetailContainer(
      {Key? key,
      required this.product,
      required this.colorList,
      required this.varientList})
      : super(key: key);

  @override
  State<ProductDetailContainer> createState() => _ProductDetailContainerState();
}

class _ProductDetailContainerState extends State<ProductDetailContainer> {
  final _dropdownItems = ['1', '2', '3', '4', '5'];
  List<ColorModel> _colorList = [];
  late ColorModel _selectedColor;
  double _mainPrice = 0.0;
  int _offer = 0;
  int _offerPrice = 0;
  List<VarientDetail> _selectedVarients = [];

  @override
  void initState() {
    _colorList = widget.colorList;
    _selectedColor = _colorList.first;
    _mainPrice = widget.product.mainPrice.toDouble();
    _offer = widget.product.mainOff.toInt();
    _mainPrice += _selectedColor.colorPriceChange;
    _offer += _selectedColor.colorOfferChange;
    for (Varient varient in widget.varientList) {
      final varientDetail = varient.varientList.first;
      if (varient.varientList.isNotEmpty) {
        _selectedVarients.add(varientDetail);
        _mainPrice += varientDetail.priceChange;
        _offer += varientDetail.offerChange;
      }
    }
    _offerPrice =
        PriceService.calculate(price: _mainPrice, offer: _offer).offerPrice;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
                child: Image.network(
              'https://firebasestorage.googleapis.com/v0/b/miraki-app.appspot.com/o/india_flag.png?alt=media&token=f0a962ca-a29e-4e36-85b6-cef750f17cac',
              fit: BoxFit.cover,
            )),
            Positioned.fill(
              child: Container(
                color: AppColor.light,
              ),
            ),
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: HeaderWidget(
                    colorModel: _selectedColor,
                    product: widget.product,
                  ),
                ),
                _divider,
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getIndianCurrency(_offerPrice.toDouble()),
                              style: const TextStyle(
                                  fontSize: 25.0, fontWeight: FontWeight.w500),
                            ),
                            Expanded(
                              child: Wrap(
                                alignment: WrapAlignment.end,
                                children: const [
                                  RatingStar(
                                    itemSize: 18.0,
                                  ),
                                  Text(
                                    ' (2,000)',
                                    style: TextStyle(
                                        color: AppColor.accentColor,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        spaceOf8,
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                            text: 'M.R.P.: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColor.darkColor.withOpacity(.5),
                            ),
                          ),
                          TextSpan(
                            text: getIndianCurrency(_mainPrice),
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: AppColor.darkColor.withOpacity(.5),
                                decoration: TextDecoration.lineThrough),
                          ),
                        ])),
                        spaceOf8,
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                            text: '$_offer % Off - ',
                            style: const TextStyle(
                              color: AppColor.primaryColorDark,
                            ),
                          ),
                          TextSpan(
                            text:
                                'You Save  ${getIndianCurrency(_mainPrice - _offerPrice)}',
                            style: const TextStyle(
                              color: AppColor.secondaryColor,
                            ),
                          ),
                        ])),
                        spaceOf10,
                        const Text(
                          'Free Scheduled Delivery',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                _divider,
                /* ==============
                  Color widget
                  ============== */
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  sliver: SliverToBoxAdapter(
                    child: ColorWidget(
                        colorList: _colorList,
                        selectedColor: _selectedColor,
                        onSelected: (colorModel) {
                          setState(() {
                            _mainPrice -= _selectedColor.colorPriceChange;
                            _offer -= _selectedColor.colorOfferChange;
                            _mainPrice += colorModel.colorPriceChange;
                            _offer += colorModel.colorOfferChange;
                            _selectedColor = colorModel;
                            _offerPrice = PriceService.calculate(
                                    price: _mainPrice, offer: _offer)
                                .offerPrice;
                          });
                        }),
                  ),
                ),
                /* ==============
                  varient widget
                  ============== */
                SliverToBoxAdapter(
                  child: VarientWidget(
                    varientList: widget.varientList,
                    onSelectVarient: (selectedVarients) {
                      setState(() {
                        for (VarientDetail varientDetail in _selectedVarients) {
                          _mainPrice -= varientDetail.priceChange;
                          _offer -= varientDetail.offerChange;
                        }
                        for (VarientDetail varientDetail in selectedVarients) {
                          _mainPrice += varientDetail.priceChange;
                          _offer += varientDetail.offerChange;
                        }
                        _selectedVarients = selectedVarients;
                        _offerPrice = PriceService.calculate(
                                price: _mainPrice, offer: _offer)
                            .offerPrice;
                      });
                    },
                  ),
                ),
                _divider,
                /* ==============
                  Total price
                  ============== */
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        RichText(
                            text: TextSpan(children: [
                          const TextSpan(
                            text: 'Total: ',
                            style: TextStyle(
                              color: AppColor.darkColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: getIndianCurrency(_offerPrice.toDouble()),
                            style: const TextStyle(
                                color: AppColor.darkColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0),
                          ),
                        ])),
                        spaceOf10,
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              color: AppColor.accentColor,
                              size: 15.0,
                            ),
                            const SizedBox(
                              width: 3.0,
                            ),
                            RichText(
                                text: const TextSpan(
                                    text: 'Select delivery location',
                                    style:
                                        TextStyle(color: AppColor.accentColor)))
                          ],
                        ),
                        const SizedBox(
                          height: 14.0,
                        ),
                        /* ==============
                          Product action
                          ============== */
                        Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            borderRadius: BorderRadius.circular(8.0),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8.0),
                              onTap: () {},
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 3.0, horizontal: 10.0),
                                child: DropdownButton<String>(
                                  dropdownColor: const Color(0xFFefefef),
                                  // value: '${widget.cart.itemQuantity}',
                                  elevation: 0,
                                  isDense: true,
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 22.0,
                                  ),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  underline: Container(),
                                  iconEnabledColor: Colors.black,
                                  items: _dropdownItems
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                          color: value != 'More'
                                              ? Colors.black
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  hint: const Text(
                                    "Quantity: 6",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  onChanged: (value) {},
                                ),
                                decoration: BoxDecoration(
                                    color: AppColor.lightGrey.withOpacity(.1),
                                    border:
                                        Border.all(color: AppColor.lightGrey),
                                    borderRadius: BorderRadius.circular(8.0)),
                              ),
                            ),
                          ),
                        ),
                        spaceOf16,
                        const ProductActionButton(
                          label: 'Buy Now',
                        ),
                        spaceOf10,
                        const ProductActionButton(
                          label: 'Add to Cart',
                          color: AppColor.secondaryColor,
                          textColor: AppColor.light,
                        ),
                        spaceOf16,
                        /* ==============
                          Product information
                          ============== */
                        const Text(
                          'Specifications',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15.0),
                        ),
                        spaceOf10,
                        ...widget.product.specifications.map((e) => Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: CircleAvatar(
                                        radius: 2.5,
                                        backgroundColor: AppColor.darkColor,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 8,
                                      child: Text(
                                        e,
                                        style: const TextStyle(
                                            height: 1.4, fontSize: 14.0),
                                      ))
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: spaceOf16,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget get _divider => SliverToBoxAdapter(
      child: Divider(
        height: 40.0,
        color: AppColor.lightGrey.withOpacity(.2),
        thickness: 5.0,
      ),
    );

Widget get _thinDivider => SliverToBoxAdapter(
      child: Divider(
        height: 40.0,
        color: AppColor.lightGrey.withOpacity(.2),
        thickness: 2.0,
      ),
    );
