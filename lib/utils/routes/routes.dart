import 'package:safewalk/ui/auth/register/biodata.dart';
import 'package:safewalk/ui/auth/register/register.dart';
import 'package:safewalk/ui/auth/register/selfpict.dart';
import 'package:safewalk/ui/auth/register/success.dart';
import 'package:safewalk/ui/home/home.dart';
import 'package:safewalk/ui/auth/login/login.dart';
import 'package:safewalk/ui/maps/distance.dart';
import 'package:safewalk/ui/maps/maps.dart';
import 'package:safewalk/ui/dev/navigator.dart';
import 'package:safewalk/ui/onboard/onboarding.dart';
import 'package:safewalk/ui/post/post.dart';
import 'package:safewalk/ui/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:safewalk/ui/storage/library.dart';
import 'package:safewalk/ui/storage/storage.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';
  static const String map = '/map';
  static const String distanceMap = '/distanceMap';
  static const String post = '/post';

  static const String onboarding = '/onboarding';
  static const String register = '/register';
  static const String biodata = '/biodata';
  static const String selfpict = '/selfpict';
  static const String success = '/success';

  static const String storage = '/storage';
  static const String library = '/library';
  static const String navigator = '/navigator';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    login: (BuildContext context) => LoginScreen(),
    home: (BuildContext context) => HomeScreen(),
    map: (BuildContext context) => MapsScreen(),
    distanceMap: (BuildContext context) => MapDistanceScreen(),
    post: (BuildContext context) => PostScreen(),
    onboarding: (BuildContext context) => OnboardingAnimationScreen(),
    register: (BuildContext context) => RegisterScreen(),
    biodata: (BuildContext context) => BiodataScreen(),
    selfpict: (BuildContext context) => SelfPictScreen(),
    success: (BuildContext context) => SuccessScreen(),

    storage: (BuildContext context) => StorageScreen(),
    library: (BuildContext context) => LibraryScreen(),
    navigator: (BuildContext context) => NavigatorScreen(),
  };
}
