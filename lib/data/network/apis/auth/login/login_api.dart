import 'dart:async';

import 'package:safewalk/data/network/constants/endpoints.dart';
import 'package:safewalk/data/network/dio_client.dart';
import 'package:safewalk/data/network/exceptions/network_exceptions.dart';

class LoginApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  LoginApi(this._dioClient);

  /// Returns list of post in response
  Future<dynamic> loginManual(
    String email,
    String password,
  ) async {
    try {
      final res = await _dioClient.post(Endpoints.loginManual, data: {
        "email": email,
        "password": password,
      });
      return res;
    } catch (e) {
      throw NetworkException(message: e.toString());
    }
  }
}
