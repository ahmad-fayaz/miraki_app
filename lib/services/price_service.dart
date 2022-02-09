class PriceService {
  final num price;
  final num offer;

  PriceService.calculate({
    required this.price,
    required this.offer
  });

  double get finalPrice => (offer * price) / 100;

  int get offerPrice => (price - finalPrice).ceil();
}