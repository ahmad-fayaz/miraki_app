class OrderPayment {
  final bool isOnlinePayment;
  final num mainPrice;
  final num offerPrice;
  final num refundDays;
  final int gstPercent;

  OrderPayment({
    required this.isOnlinePayment,
    required this.mainPrice,
    required this.offerPrice,
    required this.refundDays,
    required this.gstPercent,
  });

  OrderPayment.fromJson(Map<String, Object?> json)
      : this(
          isOnlinePayment: json['isOnlinePayment']! as bool,
          mainPrice: json['mainPrice']! as num,
          offerPrice: json['offerPrice']! as num,
          refundDays: json['refundDays']! as num,
          gstPercent: json['gstPercent']! as int,
        );

  Map<String, Object?> toJson() => {
        'isOnlinePayment': isOnlinePayment,
        'mainPrice': mainPrice,
        'offerPrice': offerPrice,
        'refundDays': refundDays,
        'gstPercent': gstPercent,
      };
}
