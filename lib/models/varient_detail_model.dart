class VarientDetail {
  final String valueName;
  num priceChange;
  int offerChange;
  bool isDefault;

  VarientDetail(
      {required this.valueName,
      required this.priceChange,
      required this.offerChange,
      this.isDefault = false});

  VarientDetail.fromJson(Map<String, Object?> json)
      : this(
          valueName: json['valueName']! as String,
          priceChange: json['priceChange']! as num,
          offerChange: json['offerChange']! as int,
          isDefault: json['isDefault']! as bool,
        );

  Map<String, Object?> toJson() => {
    'valueName': valueName,
    'priceChange': priceChange,
    'offerChange': offerChange,
    'isDefault': isDefault,
  };
}
