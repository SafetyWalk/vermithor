import 'package:safewalk/constants/environment.dart';

class Endpoints {
  Endpoints._();

  // post url
  static final String postUrl = "https://jsonplaceholder.typicode.com";

  // base url
  static final String baseUrl = Environment.asclepiusURL;

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 30000;

  // booking endpoints
  static final String getPosts = postUrl + "/posts";

  // login endpoints
  static final String auth = baseUrl + "/authentication";
  static final String loginRegular = auth + "/manual-user";
  static final String loginGoogle = auth + "/google-user";
}