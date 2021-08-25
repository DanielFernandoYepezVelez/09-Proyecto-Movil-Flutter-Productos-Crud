import 'dart:convert';

class ProductResponse {
  String name;
  String? picture;
  double price;
  bool available;
  String? id;

  ProductResponse({
    required this.name,
    this.picture,
    required this.price,
    required this.available,
  });

  factory ProductResponse.fromJson(String str) =>
      ProductResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductResponse.fromMap(Map<String, dynamic> json) => ProductResponse(
        name: json["name"],
        picture: json["picture"],
        price: json["price"].toDouble(),
        available: json["available"] == null ? null : json["available"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "picture": picture,
        "price": price,
        "available": available == null ? null : available,
      };
}
