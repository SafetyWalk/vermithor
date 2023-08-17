import 'package:safewalk/constants/environment.dart';

class Endpoints {
  Endpoints._();

  // post url
  static final String postUrl = "https://jsonplaceholder.typicode.com";

  // base url
  // static final String baseUrl = Environment.asclepiusURL;
  static final String baseUrl = "http://127.0.0.1:8000/api/v1";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 30000;

  // booking endpoints
  static final String getPosts = postUrl + "/posts";

  // authentication endpoints
  static final String auth = baseUrl + "/authentication";
  static final String loginManual = auth + "/manual-user/login/";
  static final String loginGoogle = auth + "/google-user/login/";
  static final String registerManual = auth + "/manual-user/";
  static final String registerGoogle = auth + "/google-user/";
  static final String editPassword = auth + "/manual-user/edit/password/";

  // profile endpoints
  static final String profile = baseUrl + "/profile/";
  static final String profileManual = profile + "/manual-user/";
  static final String profileGoogle = profile + "/google-user/";
}
