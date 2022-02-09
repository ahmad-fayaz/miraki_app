import 'package:miraki_app/models/varient_detail_model.dart';

class Varient {
  final String name;
  final List<VarientDetail> varientList;

  Varient({required this.name, required this.varientList});

  Varient.fromJson(Map<String, Object?> json)
      : this(
          name: json['name']! as String,
          varientList: (json['varientList']! as List<dynamic>)
              .map((e) => VarientDetail.fromJson(e))
              .toList(),
        );

  Map<String, Object?> toJson() => {
        'name': name,
        'varientList': varientList.map((e) => e.toJson()).toList()
      };
}
