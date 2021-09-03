import 'package:flutter/material.dart';

/* Models */
import 'package:productos_app/models/models.dart';

class ProductFormProvider extends ChangeNotifier {
  ProductResponse product;
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  ProductFormProvider(this.product);

  updateAvailability(bool value) {
    // print(value);
    this.product.available = value;
    notifyListeners();
  }

  bool isValidForm() {
    // print(this.product.name);
    // print(this.product.price);
    return this.formKey.currentState?.validate() ?? false;
  }
}
