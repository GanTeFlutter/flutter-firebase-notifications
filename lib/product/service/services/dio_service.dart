import 'package:dio/dio.dart';
import 'package:flutter_base_start/product/service/service_locator.dart';

class HTTPService {
  HTTPService({
    required this.baseUrl,
    required this.apiKey,
    required this.dio,
  }) {
    _configureDio();
  }
  final Dio dio;
  final String baseUrl;
  final String apiKey;

  //log tutmak için dinleyiciler ekler ve dio yapılandırır
  void _configureDio() {
    //baseUrl: API'nin temel URL'si
    dio.options.baseUrl = baseUrl;

    //connectTimeout: Sunucuya bağlanmak için beklenen maksimum süre
    dio.options.connectTimeout = const Duration(seconds: 10);

    //receiveTimeout: Verinin alınması için beklenen maksimum süre
    dio.options.receiveTimeout = const Duration(seconds: 10);

    //dio dinleyici
    dio.interceptors.add(
      InterceptorsWrapper(
        //Her istek atıldığında çalışır.
        onRequest: (options, handler) {
          locator.logger.d(
            'REQUEST[${options.method}] => PATH: ${options.path}',
          );
          return handler.next(options);
        },
        //İstek başarıyla yanıt döndüğünde çalışır.
        onResponse: (response, handler) {
          locator.logger.d(
            'RESPONSE[${response.statusCode}] => DATA: ${response.data}',
          );
          return handler.next(response);
        },
        //Herhangi bir hata olduğunda çalışır.
        onError: (error, handler) {
          locator.logger.e(
            'ERROR[${error.response?.statusCode}] => MESSAGE: ${error.message}',
          );
          return handler.next(error);
        },
      ),
    );
  }

  // otamatik olarak her isteğe eklenen ortak sorgu parametrelerini oluşturur
  Map<String, dynamic> _buildQueryParams(Map<String, dynamic>? query) {
    return {'api_key': apiKey, 'language': 'en-US', ...?query};
  }

  // HTTP methods
  Future<Response<Map<String, dynamic>>?> get(
    String path, {
    Map<String, dynamic>? query,
  }) async {
    try {
      return await dio.get<Map<String, dynamic>>(
        path,
        queryParameters: _buildQueryParams(query),
      );
    } on DioException catch (e) {
      _handleError(e);
      return null;
    }
  }

  Future<Response<Map<String, dynamic>>?> post(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
  }) async {
    try {
      return await dio.post<Map<String, dynamic>>(
        path,
        data: data,
        queryParameters: _buildQueryParams(query),
      );
    } on DioException catch (e) {
      _handleError(e);
      return null;
    }
  }

  Future<Response<Map<String, dynamic>>?> put(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
  }) async {
    try {
      return await dio.put<Map<String, dynamic>>(
        path,
        data: data,
        queryParameters: _buildQueryParams(query),
      );
    } on DioException catch (e) {
      _handleError(e);
      return null;
    }
  }

  Future<Response<Map<String, dynamic>>?> delete(
    String path, {
    Map<String, dynamic>? query,
  }) async {
    try {
      return await dio.delete<Map<String, dynamic>>(
        path,
        queryParameters: _buildQueryParams(query),
      );
    } on DioException catch (e) {
      _handleError(e);
      return null;
    }
  }

  // Error handling method
  void _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        locator.logger.e('Timeout Error: ${e.message}');
      case DioExceptionType.badCertificate:
        locator.logger.e('Bad Certificate Error: ${e.message}');
      case DioExceptionType.badResponse:
        locator.logger.e(
          'Server Error: ${e.response?.statusCode} - ${e.response?.data}',
        );
      case DioExceptionType.cancel:
        locator.logger.e('Request Cancelled');
      case DioExceptionType.connectionError:
        locator.logger.e('Connection Error: No internet connection');

      case DioExceptionType.unknown:
        locator.logger.e('Unknown Error: ${e.message}');
    }
  }
}
