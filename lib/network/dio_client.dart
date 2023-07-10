import 'package:dio/dio.dart';
import 'package:nasa_apod/network/interceptors/logger_interceptor.dart';

import 'endpoints.dart';

class DioClient {
  late final Dio _dio;

  DioClient()
      : _dio = Dio(BaseOptions(
            baseUrl: Endpoints.baseURL,
            responseType: ResponseType.json))
          ..interceptors
              .addAll([LoggerInterceptor()]);

  Future<Response> getApod({required String date}) async {
    final Response response;

    try {
      Map<String, dynamic> data = {"date": date, "hd": true, "api_key": Endpoints.api_key};
      response = await _dio.get(Endpoints.apod_endpoint, queryParameters: data);
    } on DioException catch (err) {
      throw err;
    } catch (e) {
      throw e;
    }
    return response;
  }


}
