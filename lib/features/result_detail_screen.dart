import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pathfinding_app/bloc/path_bloc_bloc.dart';

class ResultDetailScreen extends StatefulWidget {
  final Map<String, dynamic> pathData;
  final int gridSize;
  ResultDetailScreen({required this.pathData, required this.gridSize});

  @override
  State<ResultDetailScreen> createState() => _ResultDetailScreenState();
}

class _ResultDetailScreenState extends State<ResultDetailScreen> {
  @override
  Widget build(BuildContext context) {
    List steps = widget.pathData['result']['steps'];

    return BlocProvider(
      create: (context) => PathBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Result Details'),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(color: Colors.black, width: 1)),
                  child: _buildGrid(widget.gridSize, steps),
                ),
                const SizedBox(height: 20),
                Text(
                  widget.pathData['result']['path'].toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildGrid(int size, List steps) {
  return GridView.builder(
    shrinkWrap: true,
    itemCount: size * size,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: size,
    ),
    itemBuilder: (context, index) {
      int x = index % size;
      int y = index ~/ size;
      Color cellColor = _getCellColor(x, y, steps);

      return Container(
        margin: const EdgeInsets.all(1),
        color: cellColor,
        child: Center(
          child: Text(
            '($x, $y)',
            style: TextStyle(
              color: cellColor == Colors.black ? Colors.white : Colors.black,
            ),
          ),
        ),
      );
    },
  );
}

Color _getCellColor(int x, int y, List steps) {
  if (steps.isNotEmpty) {
    if (x == steps.first['x'] && y == steps.first['y']) {
      return const Color(0xFF64FFDA);
    } else if (x == steps.last['x'] && y == steps.last['y']) {
      return const Color(0xFF009688);
    } else if (steps.any((step) => step['x'] == x && step['y'] == y)) {
      return const Color(0xFF4CAF50);
    }
  }
  return Colors.white;
}
