import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  /* El Valor De Estas Propiedades Se Asigna En El Onchanged Del Form */
  String email = '';
  String password = '';
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    this._isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    /* Aqui Tenemos El Estado Del Formulario, Si Pasa O No Pasa */
    // print(formKey.currentState?.validate());
    return formKey.currentState?.validate() ?? false;
  }
}
