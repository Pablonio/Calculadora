import 'package:flutter/material.dart';

class CustomNavbar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomNavbar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Sumar'),
        BottomNavigationBarItem(icon: Icon(Icons.remove), label: 'Restar'),
        BottomNavigationBarItem(
            icon: Icon(Icons.horizontal_rule),
            label: 'Multiplicar'), // Updated icon
        BottomNavigationBarItem(
            icon: Icon(Icons.calculate), label: 'Dividir'), // Updated icon
      ],
    );
  }
}
