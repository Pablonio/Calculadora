import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PantallaComplemento extends StatefulWidget {
  @override
  _PantallaComplementoState createState() => _PantallaComplementoState();
}

class _PantallaComplementoState extends State<PantallaComplemento> {
  final _complaintController = TextEditingController();
  final List<String> _complaints = []; // Lista para almacenar las quejas

  @override
  void initState() {
    super.initState();
    _loadComplaints(); // Cargar quejas al iniciar
  }

  void _loadComplaints() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _complaints.addAll(prefs.getStringList('complaints') ?? []);
    });
  }

  void _registerComplaint() async {
    final complaintText = _complaintController.text;

    if (complaintText.isNotEmpty) {
      setState(() {
        _complaints.add(complaintText);
      });

      // Guardar quejas en shared_preferences
      final prefs = await SharedPreferences.getInstance();
      prefs.setStringList('complaints', _complaints);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Queja registrada: $complaintText')),
      );

      _complaintController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, ingresa una queja')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registrar Quejas')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _complaintController,
              decoration: InputDecoration(labelText: 'Ingresa tu queja aquí'),
              maxLines: 5,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _registerComplaint,
              child: Text('Registrar Queja'),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _complaints.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_complaints[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
