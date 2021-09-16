import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/* Models */
import 'package:productos_app/models/models.dart';

/* Screens */
import 'package:productos_app/screens/screens.dart';

/* Widgets */
import 'package:productos_app/widgets/widgets.dart';

/* Services */
import 'package:productos_app/services/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);
    final authService = Provider.of<AuthService>(context, listen: false);

    if (productsService.isLoading) return LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.logout_outlined),
          onPressed: () {
            authService.logout();
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
      ),
      body: ListView.builder(
        itemCount: productsService.products.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          onTap: () {
            productsService.selectedProduct =
                productsService.products[index].copy();
            Navigator.pushNamed(context, 'product');
          },
          child: ProductCard(product: productsService.products[index]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          productsService.selectedProduct =
              new ProductResponse(name: '', price: 0, available: false);
          Navigator.pushNamed(context, 'product');
        },
      ),
    );
  }
}
