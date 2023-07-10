import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nasa_apod/models/apod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../db/db_helper.dart';
import '../network/dio_client.dart';
import '../network/dio_exception_handler.dart';

class ApodProvider extends ChangeNotifier {
  Apod? apod;
  DioClient dioClient = DioClient();
  final DbHelper dbHelper = DbHelper();

  late DateTime currentDate;
  bool themeModeDark = false;
  bool isFavorite = false;
  bool isInternet = true;
  String errorMessage = '';

  changeThemeMode() async {
    themeModeDark = !themeModeDark;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('theme', themeModeDark);
    notifyListeners();
  }

  getFavoriteStatus() async {
    isFavorite = await dbHelper
        .checkFavorite((isInternet) ? getCurrentDateString() : apod!.date);
    notifyListeners();
  }

  String getCurrentDateString() {
    return "${currentDate.year}-${(currentDate.month.toString().length == 1) ? '0${currentDate.month}' : currentDate.month}-${(currentDate.day.toString().length == 1) ? '0${currentDate.day}' : currentDate.day}";
  }

  String getCurrentDisplayDateString() {
    return "${(currentDate.day.toString().length == 1) ? '0${currentDate.day}' : currentDate.day}-${(currentDate.month.toString().length == 1) ? '0${currentDate.month}' : currentDate.month}-${currentDate.year}";
  }

  Future<Apod?> getApod({required String date}) async {
    isInternet = true;
    errorMessage = '';
    try {
      apod = null;
      Response result = await dioClient.getApod(date: date);

      apod = Apod.fromJson(result.data);

      try {
        dbHelper.deleteModel();
      } catch (e) {
        if (kDebugMode) print(e);
      }
      try {
        apod!.display_date = getCurrentDisplayDateString();
        dbHelper.insertAPOD(apod!);
      } catch (e) {
        if (kDebugMode) print(e);
      }

      notifyListeners();
      return apod;
    } on DioException catch (err) {
      if (err.error.toString().contains('SocketException')) {
        getLastAPOD();
      } else {
        errorMessage = DioExceptionHandler.fromDioError(err).toString();
        notifyListeners();

      }
    } catch (err) {
      errorMessage = err.toString();
      notifyListeners();
    }
  }

  getLastAPOD() async {
    apod = null;
    isInternet = false;
    try {
      apod = await dbHelper.getLastAPOD();
      getFavoriteStatus();
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }

}
