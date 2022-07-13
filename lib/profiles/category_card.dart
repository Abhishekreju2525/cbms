import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String CategoryName;

  CategoryCard({
    required this.CategoryName,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.deepPurple[100],
        ),
        child: Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Text(CategoryName),
          ],
        ),
      ),
    );
  }
}
