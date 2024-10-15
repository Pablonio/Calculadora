import 'package:flutter/material.dart';
import 'package:myapp/serviciosUsuario.dart'; // Asegúrate de que este import sea correcto
import 'pantallaRegistro.dart'; // Importa la pantalla de registro
import 'pantallaComplemento.dart'; // Importa la pantalla complementaria

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final UserService _userService = UserService();

  void _login() async {
    // Intenta iniciar sesión con el nombre de usuario y la contraseña ingresados
    var user = await _userService.loginUser(
      _usernameController.text,
      _passwordController.text,
    );

    // Verifica si el usuario fue encontrado
    if (user != null) {
      // Navega a la pantalla complementaria
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                PantallaComplemento()), // Cambia aquí a la pantalla complementaria
      );
    } else {
      // Muestra un mensaje de error si las credenciales son incorrectas
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuario o contraseña incorrectos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Iniciar Sesión')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Usuario'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: _login,
              child: Text('Iniciar Sesión'),
            ),
            TextButton(
              onPressed: () {
                // Navega a la pantalla de registro
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
              child: Text('¿No tienes cuenta? Regístrate'),
            ),
          ],
        ),
      ),
    );
  }
}
