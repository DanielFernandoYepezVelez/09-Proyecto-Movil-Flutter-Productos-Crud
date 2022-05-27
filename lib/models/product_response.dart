import 'dart:convert';

class ProductResponse {
  String? id;
  String name;
  double price;
  bool available;
  String? picture;

  ProductResponse({
    this.id,
    this.picture,
    required this.name,
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

  /* Aquí me estoy creando un metodo para romper la referencia del objeto */
  ProductResponse copy() => ProductResponse(
        id: id,
        name: name,
        price: price,
        picture: picture,
        available: available,
      );
}
