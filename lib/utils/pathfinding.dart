import 'dart:collection';
import '../models/grid_data_model.dart';

class Pathfinding {
  static Result findShortestPath(
      List<String> grid, Coordinate start, Coordinate end) {
    final int n = grid.length;
    final int m = grid[0].length;
    final List<List<bool>> visited =
        List.generate(n, (_) => List.generate(m, (_) => false));
    final Queue<List<Coordinate>> queue = Queue();
    final List<Coordinate> directions = [
      Coordinate(0, 1),
      Coordinate(1, 0),
      Coordinate(0, -1),
      Coordinate(-1, 0),
      Coordinate(1, 1),
      Coordinate(1, -1),
      Coordinate(-1, 1),
      Coordinate(-1, -1)
    ];

    queue.add([start]);
    visited[start.x][start.y] = true;

    while (queue.isNotEmpty) {
      final path = queue.removeFirst();
      final current = path.last;

      if (current.x == end.x && current.y == end.y) {
        final pathStr =
            path.map((coord) => '(${coord.x},${coord.y})').join('->');
        return Result(steps: path, path: pathStr);
      }

      for (var direction in directions) {
        final newX = current.x + direction.x;
        final newY = current.y + direction.y;

        if (newX >= 0 &&
            newX < n &&
            newY >= 0 &&
            newY < m &&
            grid[newX][newY] == '.' &&
            !visited[newX][newY]) {
          visited[newX][newY] = true;
          final newPath = List<Coordinate>.from(path)
            ..add(Coordinate(newX, newY));
          queue.add(newPath);
        }
      }
    }

    return Result(steps: [], path: 'Path not found');
  }
}
