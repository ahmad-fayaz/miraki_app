class OrderUser {
  final String userId;
  final String userName;
  final String phone;
  final String address;
  final String pinCode;

  OrderUser(
      {required this.userId,
      required this.userName,
      required this.phone,
      required this.address,
      required this.pinCode});

  OrderUser.fromJson(Map<String, Object?> json)
      : this(
          userId: json['userId']! as String,
          userName: json['userName']! as String,
          phone: json['phone']! as String,
          address: json['address']! as String,
          pinCode: json['pinCode']! as String,
        );

  Map<String, Object?> toJson() => {
        'userId': userId,
        'userName': userName,
        'phone': phone,
        'address': address,
        'pinCode': pinCode,
      };
}
