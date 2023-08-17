import 'dart:async';

import 'package:safewalk/data/network/constants/endpoints.dart';
import 'package:safewalk/data/network/dio_client.dart';
import 'package:safewalk/data/network/exceptions/network_exceptions.dart';

class RegisterApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  RegisterApi(this._dioClient);

  Future<dynamic> registerManual(
    String username,
    String email,
    String, password,
    String first_name,
    String last_name,
    String mobile_number,
    String photo_url,
  ) async {
    try {
      final res = await _dioClient.post(Endpoints.loginManual, data: {
        "username": username,
        "email": email,
        "password": password,
        "first_name": first_name,
        "last_name": last_name,
        "mobile_number": mobile_number,
        "photo_url": photo_url
      });
      return res;
    } catch (e) {
      throw NetworkException(message: e.toString());
    }
  }

  Future<dynamic> registerGoogle(
    String google_uid,
    String email,
    String password,
    String name,
    String mobile_number,
    String photo_url,
  ) async {
    try {
      final res = await _dioClient.post(Endpoints.loginGoogle, data: {
        "google_uid": google_uid,
        "email": email,
        "password": password,
        "name": name,
        "mobile_number": mobile_number,
        "photo_url": photo_url
      });
      return res;
    } catch (e) {
      throw NetworkException(message: e.toString());
    }
  }
}
