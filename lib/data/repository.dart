import 'dart:async';

import 'package:safewalk/data/local/datasources/post/post_datasource.dart';
import 'package:safewalk/data/network/apis/auth/login/login_api.dart';
import 'package:safewalk/data/network/apis/auth/register/register_api.dart';
import 'package:safewalk/data/sharedpref/shared_preference_helper.dart';
import 'package:safewalk/models/post/post.dart';
import 'package:safewalk/models/post/post_list.dart';
import 'package:sembast/sembast.dart';

import 'local/constants/db_constants.dart';
import 'network/apis/posts/post_api.dart';

class Repository {
  // data source object
  final PostDataSource _postDataSource;

  // api objects
  final PostApi _postApi;
  final LoginApi _loginApi;
  final RegisterApi _registerApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  Repository(this._postApi, this._loginApi, this._registerApi, this._sharedPrefsHelper,
      this._postDataSource);

  // Post: ---------------------------------------------------------------------
  Future<PostList> getPosts() async {
    // check to see if posts are present in database, then fetch from database
    // else make a network call to get all posts, store them into database for
    // later use
    return await _postApi.getPosts().then((postsList) {
      postsList.posts?.forEach((post) {
        _postDataSource.insert(post);
      });

      return postsList;
    }).catchError((error) => throw error);
  }

  Future<dynamic> registerManual (
    String username,
    String email,
    String password,
    String first_name,
    String last_name,
    String mobile_number,
    String photo_url,
  ) async {
    return await _registerApi
      .registerManual(
        username,
        email,
        password,
        first_name,
        last_name,
        mobile_number,
        photo_url
      ).then((res) {
        return res;
      }).catchError((error) => throw error);
  }

  Future<dynamic> registerGoogle(
    String google_uid,
    String email,
    String name,
    String mobile_number,
    String photo_url,
  ) async {
    return await _registerApi
        .registerGoogle(google_uid, email, name, mobile_number, photo_url)
        .then((res) {
      return res;
    }).catchError((error) => throw error);
  }

  Future<List<Post>> findPostById(int id) {
    //creating filter
    List<Filter> filters = [];

    //check to see if dataLogsType is not null
    Filter dataLogTypeFilter = Filter.equals(DBConstants.FIELD_ID, id);
    filters.add(dataLogTypeFilter);

    //making db call
    return _postDataSource
        .getAllSortedByFilter(filters: filters)
        .then((posts) => posts)
        .catchError((error) => throw error);
  }

  Future<int> insert(Post post) => _postDataSource
      .insert(post)
      .then((id) => id)
      .catchError((error) => throw error);

  Future<int> update(Post post) => _postDataSource
      .update(post)
      .then((id) => id)
      .catchError((error) => throw error);

  Future<int> delete(Post post) => _postDataSource
      .update(post)
      .then((id) => id)
      .catchError((error) => throw error);

  // Login:---------------------------------------------------------------------
  Future<bool> login(String email, String password) async {
    return await _loginApi.loginManual(email, password).then((res) {
      return res;
    }).catchError((error) => throw error);
  }

  Future<void> saveIsLoggedIn(bool value) =>
      _sharedPrefsHelper.saveIsLoggedIn(value);

  Future<bool> get isLoggedIn => _sharedPrefsHelper.isLoggedIn;

  // Theme: --------------------------------------------------------------------
  Future<void> changeBrightnessToDark(bool value) =>
      _sharedPrefsHelper.changeBrightnessToDark(value);

  bool get isDarkMode => _sharedPrefsHelper.isDarkMode;

  // Language: -----------------------------------------------------------------
  Future<void> changeLanguage(String value) =>
      _sharedPrefsHelper.changeLanguage(value);

  String? get currentLanguage => _sharedPrefsHelper.currentLanguage;
}
