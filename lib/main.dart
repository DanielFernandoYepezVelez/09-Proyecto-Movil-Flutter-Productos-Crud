import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/* Routes */
import 'package:productos_app/routes/routes.dart';

/* Theme App */
import 'package:productos_app/theme/theme.dart';

/* Services */
import 'package:productos_app/services/services.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(
          create: (_) => ProductsService(),
          lazy: false,
        ),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Productos App',
      initialRoute: 'login',
      routes: appRoutes,
      theme: tema,
    );
  }
}
