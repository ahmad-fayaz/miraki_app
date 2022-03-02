class VarientDetail {
  final String varientName;
  final String valueName;
  num priceChange;
  int offerChange;
  bool isDefault;

  VarientDetail(
      {
      required this.varientName,
      required this.valueName,
      required this.priceChange,
      required this.offerChange,
      this.isDefault = false});

  VarientDetail.fromJson(Map<String, Object?> json)
      : this(
        varientName: json['varientName']! as String,
          valueName: json['valueName']! as String,
          priceChange: json['priceChange']! as num,
          offerChange: json['offerChange']! as int,
          isDefault: json['isDefault']! as bool,
        );

  Map<String, Object?> toJson() => {
    'varientName': varientName,
        'valueName': valueName,
        'priceChange': priceChange,
        'offerChange': offerChange,
        'isDefault': isDefault,
      };
}
