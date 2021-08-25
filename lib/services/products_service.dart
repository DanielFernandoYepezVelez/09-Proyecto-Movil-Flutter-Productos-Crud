/* Aquí Estamos Trabajando Con Las Peticiones http */

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

/* Models */
import 'package:productos_app/models/models.dart';

class ProductsService extends ChangeNotifier {
  bool isLoading = true;
  final String _baseUrl = 'flutter-varios-a1946-default-rtdb.firebaseio.com';
  final List<ProductResponse> products = [];

  ProductsService() {
    this.loadProducts();
  }

  Future loadProducts() async {
    final url = Uri.https(_baseUrl, 'Products.json');
    final respuesta = await http.get(url);

    // print('AQUI YO YA TENGO UN STRING => ${respuesta.body}');

    /* La Respuesta Me Viene En El Body Como Un String, Entonces 
    Debo Convertir El Body De Dicha Respuesta En Un Mapa De Nuestros 
    Productos. Con El json.decode() Mi String, Se Vuelve Un Mapa De
    Una Clave Tipo String Y Una Respuesta Dinámica */
    final Map<String, dynamic> productsMap = json.decode(respuesta.body);

    // print('AQUI YO YA TENGO UN MAPA => $productsMap');

    /* 1. Es Más Facil Iterar Listas Que Mapas, Este Mapa Se Debe Convertir En Una Lista.
       2. Debo Agregar Un Id A La Data Que Me Viene De Firebase. */

    /* El Objetivo De Este Codigo Es Tener Un Producto Completo Con ID */
    productsMap.forEach((key, value) {
      final productTemp = ProductResponse.fromMap(value);
      productTemp.id = key;
      this.products.add(productTemp);
    });

    print(this.products[0].name);
  }
}
