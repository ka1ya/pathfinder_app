import 'package:dio/dio.dart';

class ApiService {
  final Dio dio;

  ApiService() : dio = Dio();

  Future<dynamic> fetchTasks(String baseUrl) async {
    final response = await dio.get(baseUrl);
    if (response.statusCode == 200) {
      print(response.data);
      return response.data;
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<dynamic> sendResults(
      List<Map<String, dynamic>> results, String baseUrl) async {
    try {
      final response = await dio.post(
        baseUrl,
        data: results,
      );
      if (response.statusCode != 200) {
        throw Exception(
            'Failed to send results with status code: ${response.statusCode}');
      } else {
        return response.data;
      }
    } catch (e) {
      print('Error sending results: $e');
      throw Exception('Failed to send results: $e');
    }
  }
}
