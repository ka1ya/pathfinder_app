import 'package:dio/dio.dart';

class ApiService {
  final String baseUrl;
  final dio = Dio();
  ApiService(this.baseUrl);

  Future<dynamic> fetchTasks() async {
    final response = await dio.get(baseUrl);
    if (response.statusCode == 200) {
      print(response.data);
      return response;
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<void> sendResults(dynamic results) async {
    final response = await dio.post(
      baseUrl,
      queryParameters: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      data: results,
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to send results');
    }
  }
}
