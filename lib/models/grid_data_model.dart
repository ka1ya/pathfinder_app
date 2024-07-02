class GridData {
  final String id;
  final List<String> field;
  final Coordinate start;
  final Coordinate end;

  GridData({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
  });

  factory GridData.fromJson(Map<String, dynamic> json) {
    return GridData(
      id: json['id'],
      field: List<String>.from(json['field']),
      start: Coordinate.fromJson(json['start']),
      end: Coordinate.fromJson(json['end']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'field': field,
      'start': start.toJson(),
      'end': end.toJson(),
    };
  }
}

class Coordinate {
  final int x;
  final int y;

  Coordinate(this.x, this.y);

  factory Coordinate.fromJson(Map<String, dynamic> json) {
    return Coordinate(json['x'], json['y']);
  }

  Map<String, dynamic> toJson() {
    return {'x': x, 'y': y};
  }

  @override
  String toString() {
    return '{x: $x, y: $y}';
  }
}

class PathResult {
  final String id;
  final Result result;

  PathResult({required this.id, required this.result});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'result': result.toJson(),
    };
  }

  @override
  String toString() {
    return 'PathResult{id: $id, result: $result}';
  }
}

class Result {
  final List<Coordinate> steps;
  final String path;

  Result({required this.steps, required this.path});

  Map<String, dynamic> toJson() {
    return {
      'steps': steps.map((step) => step.toJson()).toList(),
      'path': path,
    };
  }

  @override
  String toString() {
    return 'Result(steps: $steps, path: $path)';
  }
}
