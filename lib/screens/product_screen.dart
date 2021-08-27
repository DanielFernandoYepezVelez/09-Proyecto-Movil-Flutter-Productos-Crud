import 'package:flutter/material.dart';
import 'package:productos_app/providers/product_form_provider.dart';
import 'package:provider/provider.dart';

/* Services */
import 'package:productos_app/services/products_service.dart';

/* UI Input */
import 'package:productos_app/ui/input_decoration.dart';

/* Widgets */
import 'package:productos_app/widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsService>(context);

    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productService.selectedProduct!),
      child: _ProductScreenBody(productService: productService),
    );
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductsService productService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(url: productService.selectedProduct!.picture),
                Positioned(
                  top: 60,
                  left: 20,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  top: 60,
                  right: 20,
                  child: IconButton(
                    icon: Icon(
                      Icons.camera_alt_outlined,
                      size: 40,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      /* TODO: Camara O Galeria */
                    },
                  ),
                ),
              ],
            ),
            _ProductForm(),
            SizedBox(height: 100),
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save_outlined),
        onPressed: () {},
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  const _ProductForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productFormProvider = Provider.of<ProductFormProvider>(context);
    final product = productFormProvider.product;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          child: Column(
            children: [
              SizedBox(height: 10),
              TextFormField(
                initialValue: product.name,
                onChanged: (value) => product.name = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'Nombre Es Obligatorio';
                },
                decoration: InputDecorations.loginInputDecoration(
                  hintText: 'Nombre Producto',
                  labelText: 'Nombre:',
                ),
              ),
              SizedBox(height: 30),
              TextFormField(
                initialValue: '${product.price}',
                onChanged: (value) => (double.tryParse(value) == null)
                    ? product.price = 0
                    : product.price = double.parse(value),
                keyboardType: TextInputType.number,
                decoration: InputDecorations.loginInputDecoration(
                  hintText: '\$150',
                  labelText: 'Precio:',
                ),
              ),
              SizedBox(height: 30),
              SwitchListTile.adaptive(
                value: product.available,
                title: Text('Disponible'),
                tileColor: Colors.indigo,
                onChanged: (value) {
                  /* TODO: Pendiente */
                },
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: Offset(0, 5),
            blurRadius: 5,
          ),
        ],
      );
}
