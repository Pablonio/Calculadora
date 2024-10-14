import 'package:flutter/material.dart';
import 'model/user.dart'; // Importar el archivo con los datos estáticos

void main() {
  runApp(MiApp());
}

class MiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Roles de Usuario',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PantallaLogin(),
    );
  }
}

class PantallaLogin extends StatefulWidget {
  @override
  _PantallaLoginState createState() => _PantallaLoginState();
}

class _PantallaLoginState extends State<PantallaLogin> {
  final TextEditingController _controladorUsuario = TextEditingController();
  final TextEditingController _controladorContrasena = TextEditingController();
  String _mensajeError = '';

  final _formKey = GlobalKey<FormState>();

  void _iniciarSesion() {
    if (_formKey.currentState!.validate()) {
      String usuario = _controladorUsuario.text;
      String contrasena = _controladorContrasena.text;

      // Verificar si el usuario existe y tiene el rol adecuado
      User? usuarioLogueado = users.firstWhere(
        (user) => user.username == usuario && user.password == contrasena,
        orElse: () => User(username: '', password: '', role: ''),
      );

      if (usuarioLogueado.username != '') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => PantallaInicio(role: usuarioLogueado.role)),
        );
      } else {
        setState(() {
          _mensajeError = 'Usuario o contraseña inválidos';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Iniciar Sesión',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _controladorUsuario,
                        decoration: InputDecoration(
                          labelText: 'Usuario',
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese su usuario';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _controladorContrasena,
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese su contraseña';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _iniciarSesion,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Iniciar Sesión',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      if (_mensajeError.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            _mensajeError,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PantallaInicio extends StatefulWidget {
  final String role;

  PantallaInicio({required this.role});

  @override
  _PantallaInicioState createState() => _PantallaInicioState();
}

class _PantallaInicioState extends State<PantallaInicio> {
  int _indiceSeleccionado = 0;

  void _seleccionarItem(int indice) {
    setState(() {
      _indiceSeleccionado = indice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página de Inicio - Rol: ${widget.role}'),
      ),
      body: Center(
        child: Text(
          'Menú seleccionado: $_indiceSeleccionado',
          style: TextStyle(fontSize: 18),
        ),
      ),
      bottomNavigationBar: _construirBarraNavegacion(),
    );
  }

  Widget _construirBarraNavegacion() {
    List<BottomNavigationBarItem> items = [];

    if (widget.role == 'admin') {
      items = [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings), label: 'Configuraciones Admin'),
        BottomNavigationBarItem(
            icon: Icon(Icons.people), label: 'Gestión de Usuarios'),
      ];
    } else if (widget.role == 'moderador') {
      items = [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
        BottomNavigationBarItem(
            icon: Icon(Icons.edit), label: 'Moderar Contenido'),
      ];
    } else {
      items = [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
      ];
    }

    return BottomNavigationBar(
      items: items,
      currentIndex: _indiceSeleccionado,
      onTap: _seleccionarItem,
    );
  }
}

/*

// main.dart
import 'package:flutter/material.dart';
import 'NavBar/Navbar.dart';
import 'Operaciones/Suma.dart';
import 'Operaciones/Resta.dart';
import 'Operaciones/Multiplicacion.dart';
import 'Operaciones//Division.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const SumaPage(),
    const RestaPage(),
    const MultiplicacionPage(),
    const DivisionPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora'),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomNavbar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
*/
