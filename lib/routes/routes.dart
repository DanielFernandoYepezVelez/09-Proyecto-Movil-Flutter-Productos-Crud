import 'package:flutter/material.dart';

/* Screens */
import 'package:flutter_productos_crud/screens/screens.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'checking': (_) => CheckAuthScreen(),
  'home': (_) => HomeScreen(),
  'login': (_) => LoginScreen(),
  'product': (_) => ProductScreen(),
  'register': (_) => RegisterScreen(),
};