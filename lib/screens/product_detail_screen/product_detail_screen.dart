import 'package:flutter/material.dart';
import 'package:miraki_app/arguments/product_detail_argument.dart';
import 'package:miraki_app/components/divider_line.dart';
import 'package:miraki_app/components/loading_bar.dart';
import 'package:miraki_app/components/mrp_price.dart';
import 'package:miraki_app/components/product_action_button.dart';
import 'package:miraki_app/constants/dimensions.dart';
import 'package:miraki_app/constants/services.dart';
import 'package:miraki_app/constants/style.dart';
import 'package:miraki_app/models/cart_model.dart';
import 'package:miraki_app/models/color_model.dart';
import 'package:miraki_app/models/product_model.dart';
import 'package:miraki_app/models/varient_detail_model.dart';
import 'package:miraki_app/models/varient_model.dart';
import 'package:miraki_app/router/router.dart';
import 'package:miraki_app/screens/product_detail_screen/widget/color_widget.dart';
import 'package:miraki_app/screens/product_detail_screen/widget/header_widget.dart';
import 'package:miraki_app/screens/product_detail_screen/widget/varient_widget.dart';
import 'package:miraki_app/services/cart_service.dart';
import 'package:miraki_app/services/currency_service.dart';
import 'package:miraki_app/services/order_service.dart';
import 'package:miraki_app/services/price_service.dart';
import 'package:miraki_app/widgets/rating_star_widget.dart';
import 'package:provider/provider.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductDetailArguments arguments;
  const ProductDetailScreen({Key? key, required this.arguments})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<DocumentSnapshot<Product>?>.value(
          initialData: null,
          value: firestoreService.productsRef.doc(arguments.productId).snapshots(),
        ),
        StreamProvider<QuerySnapshot<Varient>?>.value(
            value:
                firestoreService.getProductVarientsRef(arguments.productId).snapshots(),
            initialData: null),
        StreamProvider<QuerySnapshot<ColorModel>?>.value(
            value: firestoreService
                .getProductColorsRef(arguments.productId)
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
          selectedColorName: arguments.selectedColorName,
          selectedVarientValues: arguments.selectedVarientValues,
        );
      },
    );
  }
}

class ProductDetailContainer extends StatefulWidget {
  final Product product;
  final List<ColorModel> colorList;
  final List<Varient> varientList;
  final String? selectedColorName;
  final List<String>? selectedVarientValues;
  const ProductDetailContainer(
      {Key? key,
      required this.product,
      required this.colorList,
      required this.varientList,
      this.selectedColorName,
      this.selectedVarientValues})
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
  int _itemQuantity = 1;
  bool _showFloatingButton = false;

  @override
  void initState() {
    _colorList = widget.colorList;
    _selectedColor = _colorList.first;
    if (widget.selectedColorName != null) {
      final query = _colorList.where((element) => element.colorName == widget.selectedColorName);
      if (query.isNotEmpty) {
        _selectedColor = _colorList.where((element) => element.colorName == widget.selectedColorName).first;
      }
    }
    _mainPrice = widget.product.mainPrice.toDouble();
    _offer = widget.product.mainOff.toInt();
    _mainPrice += _selectedColor.colorPriceChange;
    _offer += _selectedColor.colorOfferChange;
    for (Varient varient in widget.varientList) {
      VarientDetail varientDetail = varient.varientList.first;
      if (widget.selectedVarientValues != null) {
        final query1 = varient.varientList.where((element1) {
          final query2 =  widget.selectedVarientValues!.where((element2) => element1.valueName == element2);
          if (query2.isNotEmpty) {
            return true;
          }
          return false;
        });
        if (query1.isNotEmpty) {
          varientDetail = query1.first;
        }
      }
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
      floatingActionButton: _showFloatingButton ? FloatingActionButton.extended(onPressed: () {
        Navigator.pushNamed(context, RouteGenerator.cartRoute);
      }, label: const Text('Go to Cart', style: TextStyle(color: AppColor.light),), backgroundColor: AppColor.accentColor,) : null,
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
                const SliverDividerLine(),
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
                        MRPPrice(price: _mainPrice),
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
                if (_colorList.length > 1) const SliverDividerLine(),
                /* ==============
                  Color widget
                  ============== */
                if (_colorList.length > 1)
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
                    selectedVarientList: _selectedVarients,
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
                const SliverDividerLine(),
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
                          Select quantity
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
                                  // value: '$_itemQuantity',
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
                                  hint: Text(
                                    "Quantity: $_itemQuantity",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    setState(() =>
                                        _itemQuantity = int.parse(value!));
                                  },
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
                        /* ==============
                          Product action
                          ============== */
                        spaceOf16,
                        ProductActionButton(
                          label: 'Buy Now',
                          onTap: () async {
                            await OrderService.placeNewOrder(
                                productId: widget.product.productId,
                                mainCategoryName:
                                    widget.product.mainCategoryName,
                                subCategoryName: widget.product.subCategoryName,
                                className: widget.product.className,
                                brandName: widget.product.brandName,
                                capacity: widget.product.capacity,
                                model: widget.product.model,
                                productImage: _selectedColor.subImages.first,
                                productName: widget.product.productName,
                                productDescription:
                                    widget.product.productDescription,
                                colorName: _selectedColor.colorName,
                                colorCode: _selectedColor.colorCode,
                                varients: _selectedVarients
                                    .map((e) => e.valueName)
                                    .toList(),
                                isOnlinePayment: false,
                                mainPrice: _mainPrice,
                                offerPrice: _offerPrice,
                                refundDays: widget.product.refundDays,
                                gstPercent: widget.product.gstPercent,
                                quantity: _itemQuantity);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Order placed succussfully')));
                          },
                        ),
                        spaceOf10,
                        ProductActionButton(
                          label: 'Add to Cart',
                          color: AppColor.secondaryColor,
                          textColor: AppColor.light,
                          onTap: () async {
                            Cart? _cart = await CartService.isExistInCart(productId: widget.product.productId colorName: _selectedColor.colorName, varients: _selectedVarients);
                            if (_cart != null) {
                              CartService.updateQuantity(_cart.cartId, _cart.quantity + 1);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Item added to cart')));
                              return;
                            }
                            await CartService.addToCart(
                                mainCategoryId: widget.product.mainCategoryId,
                                mainCategoryName:
                                    widget.product.mainCategoryName,
                                subCategoryId: widget.product.subCategoryId,
                                subCategoryName: widget.product.subCategoryName,
                                classId: widget.product.classId,
                                className: widget.product.className,
                                brandId: widget.product.brandId,
                                brandName: widget.product.brandName,
                                mainImage: _selectedColor.subImages.first,
                                productId: widget.product.productId,
                                productName: widget.product.productName,
                                productDescription:
                                    widget.product.productDescription,
                                colorName: _selectedColor.colorName,
                                colorCode: _selectedColor.colorCode,
                                price: _mainPrice,
                                offer: _offer,
                                refundDays: widget.product.refundDays.toInt(),
                                gstPercent: widget.product.gstPercent,
                                mirakiPercent: widget.product.mirakiPercent,
                                varients: _selectedVarients
                                    .map((varient) =>
                                        '${varient.varientName}: ${varient.valueName}')
                                    .toList(),
                                quantity: _itemQuantity);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Item added to cart')));
                                setState(() {
                                  _showFloatingButton = true;
                                });
                          },
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
