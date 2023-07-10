import 'package:dio/dio.dart';

import 'constants.dart';


class DioExceptionHandler implements Exception {
  late String errorMessage;

  DioExceptionHandler.fromDioError(DioException dioException) {

    switch (dioException.type) {
      case DioExceptionType.cancel:
        errorMessage = 'Request to the server was cancelled.';
        break;
      case DioExceptionType.connectionTimeout:
        errorMessage = 'Connection timed out.';
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = 'Receiving timeout occurred.';
        break;
      case DioExceptionType.sendTimeout:
        errorMessage = 'Request send timeout.';
        break;
      case DioExceptionType.badResponse:
        errorMessage = _handleStatusCode(dioException.response?.statusCode);
        break;
      case DioExceptionType.unknown:
        if (dioException.error.toString().contains('SocketException')) {
          errorMessage = 'No Internet.';
          break;
        }
        errorMessage = 'Unexpected error occurred.';
        break;
      default:
        errorMessage = 'Something went wrong';
        break;
    }
  }

  String _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case Constants.httpResponseCode400:
        return 'Oops! Something went wrong!';
      case Constants.httpResponseCode401:
        return 'Session Expired.';
      case Constants.httpResponseCode403:
        return 'The authenticated user is not allowed to access the specified API endpoint.';
      case Constants.httpResponseCode404:
        return 'The requested resource does not exist.';
      case Constants.httpResponseCode405:
        return 'Method not allowed. Please check the Allow header for the allowed HTTP methods.';
      case Constants.httpResponseCode415:
        return 'Unsupported media type. The requested content type or version number is invalid.';
      case Constants.httpResponseCode422:
        return 'Data validation failed.';
      case Constants.httpResponseCode429:
        return 'Too many requests.';
      case Constants.httpResponseCode500:
        return 'Internal server error.';
      default:
        return 'Oops something went wrong!';
    }
  }

  @override
  String toString() => errorMessage;
}
