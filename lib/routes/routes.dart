import 'package:flutter/material.dart';

/* Screens */
import 'package:productos_app/screens/screens.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'checking': (_) => CheckAuthScreen(),
  'home': (_) => HomeScreen(),
  'login': (_) => LoginScreen(),
  'product': (_) => ProductScreen(),
  'register': (_) => RegisterScreen(),
};
