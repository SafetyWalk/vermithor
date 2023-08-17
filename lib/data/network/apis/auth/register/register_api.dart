import 'dart:async';

import 'package:safewalk/data/network/constants/endpoints.dart';
import 'package:safewalk/data/network/dio_client.dart';
import 'package:safewalk/data/network/exceptions/network_exceptions.dart';

class RegisterApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  RegisterApi(this._dioClient);

  Future<dynamic> registerManual(dynamic data) async {
    try {
      final res = await _dioClient.post(Endpoints.loginManual, data: {
          "username": data["username"],
          "email": data["email"],
          "password": data["password"],
          "first_name": data["first_name"],
          "last_name": data["last_name"],
          "mobile_number": data["mobile_number"],
          "photo_url": data["photo_url"]
      });
      return res;
    } catch (e) {
      throw NetworkException(message: e.toString());
    }
  }

  Future<dynamic> registerGoogle(dynamic data) async {
    try {
      final res = await _dioClient.post(Endpoints.loginGoogle, data: {
          "google_uid": data["google_uid"],
          "email": data["email"],
          "password": data["password"],
          "name": data["name"],
          "mobile_number": data["mobile_number"],
          "photo_url": data["photo_url"]
      });
      return res;
    } catch (e) {
      throw NetworkException(message: e.toString());
    }
  }
}
