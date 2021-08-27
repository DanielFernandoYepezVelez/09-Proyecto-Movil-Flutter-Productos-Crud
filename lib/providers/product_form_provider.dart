import 'package:flutter/material.dart';

/* Models */
import 'package:productos_app/models/models.dart';

class ProductFormProvider extends ChangeNotifier {
  ProductResponse product;
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  ProductFormProvider(this.product);

  bool isValidForm() {
    return this.formKey.currentState?.validate() ?? false;
  }
}
