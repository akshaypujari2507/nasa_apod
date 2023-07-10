class Endpoints {
  Endpoints._();

  static const String baseURL = 'https://api.nasa.gov';
  static const String api_key = 'USE_YOUR_API_KEY';

  static const int receiveTimeout = 30000;

  static const int connectionTimeout = 30000;

  static const String apod_endpoint = '/planetary/apod';
}
