import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  late Dio _dio;
  int? userId;
  String? token;

  factory ApiClient() {
    return _instance;
  }

  ApiClient._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: dotenv.env['API_URL']!,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    ));
    _dio.interceptors.add(LogInterceptor(responseBody: true));
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioError e, handler) {
        print('Error: ${e.message}');
        return handler.next(e);
      },
    ));
  }

  Dio get dio => _dio;

  Future<Response> getRequest(String endpoint, {Map<String, dynamic>? params}) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: params);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> postRequest(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response;
    } on DioError catch (e) {
      throw Exception('Failed to make post request: ${e.message}');
    }
  }

  Future<Response> deleteRequest(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.delete(endpoint, data: data);
      return response;
    } on DioError catch (e) {
      throw Exception('Failed to make delete request: ${e.message}');
    }
  }

  Future<Response> putRequest(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      return response;
    } on DioError catch (e) {
      throw Exception('Failed to make put request: ${e.message}');
    }
  }
}
