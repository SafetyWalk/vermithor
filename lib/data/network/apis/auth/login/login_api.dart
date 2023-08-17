import 'dart:async';

import 'package:safewalk/data/network/constants/endpoints.dart';
import 'package:safewalk/data/network/dio_client.dart';
import 'package:safewalk/data/network/exceptions/network_exceptions.dart';
import 'package:safewalk/data/network/rest_client.dart';
import 'package:safewalk/models/post/post_list.dart';

class PostApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  PostApi(this._dioClient);

  /// Returns list of post in response
  Future<dynamic> loginManual(dynamic ) async {
    try {
      final res = await _dioClient.post(Endpoints.loginManual, data: {
          "username": "",
          "email": "",
          "password": "",
          "first_name": "",
          "last_name": "",
          "mobile_number": "",
          "photo_url": ""
      });
      return res;
    } catch (e) {
      throw NetworkException(message: e.toString());
    }
  }
}
