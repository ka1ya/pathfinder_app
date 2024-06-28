import 'package:flutter/material.dart';

class ResultDetailScreen extends StatelessWidget {
  final dynamic result;

  ResultDetailScreen({required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Деталі результату'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(result.toString()), // Adjust the display format as needed
            // Add grid view or other visualizations for the result details here
          ],
        ),
      ),
    );
  }
}
