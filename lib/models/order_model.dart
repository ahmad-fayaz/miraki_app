class Order {
  final String productName;
  final String productImage;
  final String colorName;
  final String colorCode;
  final List<String> varients;
  final double mainPrice;
  final double offerPrice;
  final int quantity;

  Order(
      {required this.productName,
      required this.productImage,
      required this.colorName,
      required this.colorCode,
      required this.varients,
      required this.mainPrice,
      required this.offerPrice,
      required this.quantity});

  Order.fromJson(Map<String, Object?> json) : this(
    productName: 
  );
}
