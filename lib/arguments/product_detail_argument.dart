class ProductDetailArguments {
  final String productId;
  final String? selectedColorName;
  final List<String>? selectedVarientValues;

  ProductDetailArguments({required this.productId, this.selectedColorName, this.selectedVarientValues});
}
