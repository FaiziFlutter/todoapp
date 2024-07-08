import 'package:flutter/material.dart';

class MealItemTrait extends StatelessWidget {
  const MealItemTrait({
    super.key,
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Row(children: [
      Icon(
        icon,
        size: width * 0.04,
        color: Colors.white,
      ),
      Text(
        label,
        style: TextStyle(
          fontSize: width * 0.033,
          color: Colors.white,
        ),
      ),
    ]);
  }
}
