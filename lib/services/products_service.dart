/* Aquí Estamos Trabajando Con Las Peticiones http */

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/* Models */
import 'package:productos_app/models/models.dart';

class ProductsService extends ChangeNotifier {
  File? newPictureFile;
  bool isLoading = true;
  bool isSaving = false;
  ProductResponse? selectedProduct;
  final List<ProductResponse> products = [];
  final String _baseUrl = 'flutter-varios-a1946-default-rtdb.firebaseio.com';

  final storage = new FlutterSecureStorage();

  ProductsService() {
    this.loadProducts();
  }

  Future<List<ProductResponse>> loadProducts() async {
    /* Flutter Y El Provider Es Inteligente PorQue Sabe Que El 
    Cambio Fue En Una Propiedad, Entonces No Redibuja Nada */
    this.isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'Products.json',
        {'auth': await this.storage.read(key: 'token') ?? ''});
    final respuesta = await http.get(url);

    // print('AQUI YO YA TENGO UN STRING => ${respuesta.body}');

    /* La Respuesta Me Viene En El Body Como Un String, Entonces 
    Debo Convertir El Body De Dicha Respuesta En Un Mapa De Nuestros 
    Productos. Con El json.decode() Mi String, Se Vuelve Un Mapa De
    Una Clave Tipo String Y Una Respuesta Dinámica */
    final Map<String, dynamic> productsMap = json.decode(respuesta.body);

    /* Validación Para Evitar El Error, Del Value En El ForEach() */
    if (productsMap['error'] != null) return [];

    // print('AQUI YO YA TENGO UN MAPA => $productsMap');

    /* 1. Es Más Facil Iterar Listas Que Mapas, Este Mapa Se Debe Convertir En Una Lista.
       2. Debo Agregar Un Id A La Data Que Me Viene De Firebase. */

    /* El Objetivo De Este Codigo Es Tener Un Producto Completo Con ID */
    productsMap.forEach((key, value) {
      final productTemp = ProductResponse.fromMap(value);
      productTemp.id = key;
      this.products.add(productTemp);
    });

    this.isLoading = false;
    notifyListeners();

    return this.products;
  }

  Future saveOrCreateProduct(ProductResponse product) async {
    isSaving = true;
    notifyListeners();

    if (product.id == null) {
      /* I Need Create A Product */
      await this.createProduct(product);
    } else {
      /* I Am Updating A Product */
      await this.updateProduct(product);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> updateProduct(ProductResponse product) async {
    final url = Uri.https(_baseUrl, 'Products/${product.id}.json',
        {'auth': await this.storage.read(key: 'token') ?? ''});

    final decodeData = await http.put(url, body: product.toJson());
    final respuesta = decodeData.body;

/* Aqui Obtengo El Indice Donde El Id De Los Productos Coincidan */
    final index =
        this.products.indexWhere((element) => element.id == product.id);

    this.products[index] = product;

    // print(respuesta);
    return product.id!;
  }

  Future<String> createProduct(ProductResponse product) async {
    final url = Uri.https(_baseUrl, 'Products.json',
        {'auth': await this.storage.read(key: 'token') ?? ''});

    final decodeData = await http.post(url, body: product.toJson());
    final respuesta = json.decode(decodeData.body);

    // print(respuesta); ID retornado por firebase
    product.id = respuesta['name'];
    this.products.add(product);

    return product.id!;
  }

  /* Aquí Estamos Trabajando Con La Imagenes */
  void updateSelectedProductImage(String path) {
    this.selectedProduct?.picture = path;
    this.newPictureFile = File.fromUri(Uri(path: path));
    notifyListeners();
  }

  Future<String?> uploadImage() async {
    if (this.newPictureFile == null) return null;

    this.isSaving = true;
    notifyListeners();

    /* Este Es Lo Mismo Que Uri.https() */
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dlulvgvuy/image/upload?upload_preset=rgj1pnsx');

    /* Aquí Estoy Creando La Petición Post, Todavia No Se Esta Disparando */
    final imageUploadRequest = http.MultipartRequest('POST', url);

    /* Aquí Estoy definiendo el campo file donde se va a cargar la imagen (Campo Formulario) */
    final file =
        await http.MultipartFile.fromPath('file', this.newPictureFile!.path);

    /* Aquí Estoy Adjuntando El File A La Petición POST */
    imageUploadRequest.files.add(file);

    /* Aquí Disparo Mi Petición Para Cloudinary */
    final streamResponse = await imageUploadRequest.send();
    final response = await http.Response.fromStream(streamResponse);

    if (response.statusCode != 200 && response.statusCode != 201) {
      // print('Algo Salio Mal Al Cargar La Imagen');
      // print(response.body);
      return null;
    }

    this.newPictureFile = null;

    final decodedData = json.decode(response.body);
    return decodedData['secure_url'];
  }
}
