import 'package:dio/dio.dart';

class ApiService {
  // final String baseUrl;
  final Dio dio;

  ApiService() : dio = Dio();

  Future<dynamic> fetchTasks(String baseUrl) async {
    final response = await dio.get(baseUrl);
    if (response.statusCode == 200) {
      print(response.data);
      return response;
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<dynamic> sendResults(dynamic results, String baseUrl) async {
    final response = await dio.post(
      baseUrl,
      data: results,
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to send results');
    } else {
      return response;
    }
  }
}
