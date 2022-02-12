class OrderPayment {
  final String paymentType;
  final num mainPrice;
  final num mainOff;
  final num refundDays;
  final int gstPercent;

  OrderPayment({
    required this.paymentType,
    required this.mainPrice,
    required this.mainOff,
    required this.refundDays,
    required this.gstPercent,
  });

  OrderPayment.fromJson(Map<String, Object?> json)
      : this(
          paymentType: json['paymentType']! as String,
          mainPrice: json['mainPrice']! as num,
          mainOff: json['mainOff']! as num,
          refundDays: json['refundDays']! as num,
          gstPercent: json['gstPercent']! as int,
        );

  Map<String, Object?> toJson() => {
        'paymentType': paymentType,
        'mainPrice': mainPrice,
        'mainOff': mainOff,
        'refundDays': refundDays,
        'gstPercent': gstPercent,
      };
}
