import 'package:flutter/material.dart';
import 'pantalla/pantallaInicio.dart';

void main() {
  runApp(QuejasApp());
}

class QuejasApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quejas App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginScreen(),
    );
  }
}
