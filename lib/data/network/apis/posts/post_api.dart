import 'dart:async';

import 'package:safewalk/data/network/constants/endpoints.dart';
import 'package:safewalk/data/network/dio_client.dart';
import 'package:safewalk/data/network/exceptions/network_exceptions.dart';
import 'package:safewalk/data/network/rest_client.dart';
import 'package:safewalk/models/post/post_list.dart';

class PostApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  PostApi(this._dioClient, this._restClient);

  /// Returns list of post in response
  Future<PostList> getPosts() async {
    try {
      final res = await _dioClient.get(Endpoints.getPosts);
      return PostList.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

/// sample api call with default rest client
 Future<PostList> getPostsRest() async {

   return _restClient
       .get(Endpoints.getPosts)
       .then((dynamic res) => PostList.fromJson(res))
       .catchError((error) => throw NetworkException(message: error));
 }

}
