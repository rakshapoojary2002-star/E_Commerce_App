import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
            ),
          ),
          child: Icon(
            Icons.explore,
            color: Theme.of(context).colorScheme.primary,
            size: 40,
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Your Style Your Store',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
      ],
    );
  }
}
