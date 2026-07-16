import 'package:flutter/material.dart';

class CategoryEmpty extends StatelessWidget {
  const CategoryEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.category_outlined,
            size: 70,
            color: Colors.grey,
          ),
          SizedBox(height: 12),
          Text(
            "No Categories Found",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}