import 'package:flutter/material.dart';

class adiitionalinfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const adiitionalinfo({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 9),
        Icon(
          icon,
        ),
        SizedBox(height: 9),
        Text(label, style: TextStyle(fontSize: 14)),
        Text(value,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
