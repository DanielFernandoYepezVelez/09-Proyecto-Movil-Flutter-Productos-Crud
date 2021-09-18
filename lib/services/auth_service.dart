import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyA_6nlC-dtomBtGZlZd_F7mct-GnjPg4jg';

  final storage = new FlutterSecureStorage();

  Future<String?> createUser(String email, String password) async {
    /* Datos Del Post */
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    /* Estructurando La Dirección Url */
    final url = Uri.https(
      this._baseUrl,
      '/v1/accounts:signUp',
      {'key': this._firebaseToken},
    );

    /* Disparando La Petición Http -> Ese encode Pasa El Mapa A Un String (String - Encode)*/
    final respuesta = await http.post(url, body: json.encode(authData));

    /* Obtengo La Respuesta, Que Es Un String Y La Decodifico A Un Mapa */
    final Map<String, dynamic> decodedResp = json.decode(respuesta.body);

    if (decodedResp.containsKey('idToken')) {
      /* Debemos Guardar El Token En Un Lugar Seguro */
      await this.storage.write(key: 'token', value: decodedResp['idToken']);
      // print(decodedResp['idToken']);
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }

  Future<String?> login(String email, String password) async {
    /* Datos Del Post */
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    /* Estructurando La Dirección Url */
    final url = Uri.https(
      this._baseUrl,
      '/v1/accounts:signInWithPassword',
      {'key': this._firebaseToken},
    );

    /* Disparando La Petición Http -> Ese encode Pasa El Mapa A Un String (String - Encode)*/
    final respuesta = await http.post(url, body: json.encode(authData));

    /* Obtengo La Respuesta, Que Es Un String Y La Decodifico A Un Mapa */
    final Map<String, dynamic> decodedResp = json.decode(respuesta.body);

    print(decodedResp);

    if (decodedResp.containsKey('idToken')) {
      /* Debemos Guardar El Token En Un Lugar Seguro */
      await this.storage.write(key: 'token', value: decodedResp['idToken']);
      // print(decodedResp['idToken']);
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }

  Future logout() async {
    await this.storage.delete(key: 'token');
    return;
  }

  Future<String> readToken() async {
    return await this.storage.read(key: 'token') ?? '';
  }
}
