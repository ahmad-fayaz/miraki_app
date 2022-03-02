class OrderVendor {
  final String name;
  final String phone;
  final String email;
  final String company;
  final String address;
  final String pinCode;
  final String gstIn;
  final int acceptedTime;

  OrderVendor({
    required this.name,
    required this.phone,
    required this.email,
    required this.company,
    required this.address,
    required this.pinCode,
    required this.gstIn,
    required this.acceptedTime,
  });

  OrderVendor.fromJson(Map<String, Object?> json)
      : this(
          name: json['name']! as String,
          phone: json['phone']! as String,
          email: json['email']! as String,
          company: json['company']! as String,
          address: json['address']! as String,
          pinCode: json['pinCode']! as String,
          gstIn: json['gstIn']! as String,
          acceptedTime: json['acceptedTime']! as int,
        );

  Map<String, Object?> toJson() => {
        'name': name,
        'phone': phone,
        'email': email,
        'company': company,
        'address': address,
        'pinCode': pinCode,
        'gstIn': gstIn,
        'acceptedTime': acceptedTime,
      };
}
