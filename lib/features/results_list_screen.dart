import 'package:flutter/material.dart';
import 'result_detail_screen.dart';

class ResultsListScreen extends StatelessWidget {
  final List<dynamic> results;

  ResultsListScreen({required this.results});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Результати розрахунків'),
      ),
      body: ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          final result = results[index];
          return ListTile(
            title:
                Text(result.toString()), // Adjust the display format as needed
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ResultDetailScreen(result: result)),
              );
            },
          );
        },
      ),
    );
  }
}
