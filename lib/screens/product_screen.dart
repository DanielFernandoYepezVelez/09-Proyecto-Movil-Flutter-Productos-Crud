import 'package:flutter/material.dart';

/* UI Input */
import 'package:productos_app/ui/input_decoration.dart';

/* Widgets */
import 'package:productos_app/widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(),
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
                decoration: InputDecorations.loginInputDecoration(
                  hintText: 'Nombre Producto',
                  labelText: 'Nombre:',
                ),
              ),
              SizedBox(height: 30),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecorations.loginInputDecoration(
                  hintText: '\$150',
                  labelText: 'Precio:',
                ),
              ),
              SizedBox(height: 30),
              SwitchListTile.adaptive(
                value: true,
                title: Text('Disponible'),
                tileColor: Colors.indigo,
                onChanged: (value) {},
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
