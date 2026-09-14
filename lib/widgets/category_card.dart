import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String title;

  const CategoryCard({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.indigo.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(title),
    );
  }
}