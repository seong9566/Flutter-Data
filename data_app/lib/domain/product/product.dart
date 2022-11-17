// To parse this JSON data, do
//
//     final responseDto = responseDtoFromJson(jsonString);

import 'dart:convert';

class Product {
  Product({
    required this.id,
    required this.name,
    required this.price,
  });

  int id;
  String name;
  int price;
// 통신해서 받은 json데이터를 map으로 받아서->product 로 바꾸어준다.
  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        price: json["price"],
      );

// json으로 바꾸어준다.
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
      };
}
