import 'package:flutter/material.dart';

/* Routes */
import 'package:productos_app/routes/routes.dart';
import 'package:productos_app/theme/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'login',
      routes: appRoutes,
      theme: tema,
    );
  }
}
