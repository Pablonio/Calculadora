// resta.dart
import 'package:flutter/material.dart';

class RestaPage extends StatefulWidget {
  const RestaPage({Key? key}) : super(key: key);

  @override
  State<RestaPage> createState() => _RestaPageState();
}

class _RestaPageState extends State<RestaPage> {
  final TextEditingController _num1Controller = TextEditingController();
  final TextEditingController _num2Controller = TextEditingController();
  String _result = '';

  void _calcular() {
    double num1 = double.tryParse(_num1Controller.text) ?? 0;
    double num2 = double.tryParse(_num2Controller.text) ?? 0;
    setState(() {
      _result = (num1 - num2).toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _num1Controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Número 1'),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _num2Controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Número 2'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _calcular,
            child: const Text('Restar'),
          ),
          const SizedBox(height: 16),
          Text(
            'Resultado: $_result',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _num1Controller.dispose();
    _num2Controller.dispose();
    super.dispose();
  }
}
