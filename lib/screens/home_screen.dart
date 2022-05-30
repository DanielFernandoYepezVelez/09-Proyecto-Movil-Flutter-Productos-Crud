import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/* Models */
import 'package:flutter_productos_crud/models/models.dart';

/* Screens */
import 'package:flutter_productos_crud/screens/screens.dart';

/* Widgets */
import 'package:flutter_productos_crud/widgets/widgets.dart';

/* Services */
import 'package:flutter_productos_crud/services/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NativeAd? _nativeVideoAd;
  bool _isLoadedVideoNative = false;

  @override
  void initState() {
    super.initState();
    _loadVideoNativeAd();
  }

  void _loadVideoNativeAd() {
    _nativeVideoAd = NativeAd(
      // adUnitId: 'ca-app-pub-3940256099942544/1044960115',
      adUnitId: 'ca-app-pub-2118916369098036/3995506557',
      factoryId: 'listTile',
      request: const AdRequest(),
      listener: NativeAdListener(onAdLoaded: (ad) {
        /* print('Video Ad Loaded Successfully'); */
        setState(() {
          _isLoadedVideoNative = true;
        });
      }, onAdFailedToLoad: (ad, error) {
        /* print(
            'Actually Ad Video Failed To Load ${error.message}, ${error.code}'); */
        ad.dispose();
      }),
    );

    _nativeVideoAd!.load();
  }

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
          child: Column(
            children: [
              if (index == 0)
                Container(
                  height: 300,
                  width: double.infinity,
                  color: Colors.black12,
                  alignment: _isLoadedVideoNative ? null : Alignment.center,
                  child: !_isLoadedVideoNative
                      ? FadeInImage(
                          placeholder: AssetImage('assets/giphy.gif'),
                          image: AssetImage('assets/giphy.gif'),
                        )
                      : AdWidget(ad: _nativeVideoAd!),
                ),
              ProductCard(product: productsService.products[index]),
            ],
          ),
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
