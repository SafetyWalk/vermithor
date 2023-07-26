import 'package:safewalk/ui/home/home.dart';
import 'package:safewalk/ui/login/login.dart';
import 'package:safewalk/ui/maps/maps.dart';
import 'package:safewalk/ui/post/post.dart';
import 'package:safewalk/ui/splash/splash.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';
  static const String map = '/map';
  static const String post = '/post';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    login: (BuildContext context) => LoginScreen(),
    home: (BuildContext context) => HomeScreen(),
    map : (BuildContext context) => MapsScreen(),
    post: (BuildContext context) => PostScreen(),
  };
}



