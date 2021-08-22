import 'package:flutter/material.dart';

/* Copio Todos Los Valores Del Tema, Pero Solo Voy A Cambiar
O Sobre Escribir, Lo Que Tenga Dentro Del copyWith() */

/* Si Necesito Que Varios Appbar En Diferentes Lugares Del
código Se Vean Iguales, Debo Modificar Su Estilo De Forma
Global */

/* Si Necesito Que Varios FlotingActionButton En Diferentes 
Lugares Del código Se Vean Iguales, Debo Modificar Su 
Estilo De Forma Global */

final ThemeData tema = ThemeData.light().copyWith(
  scaffoldBackgroundColor: Colors.grey[300],
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.indigo,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    elevation: 0,
    backgroundColor: Colors.indigo,
  ),
);
