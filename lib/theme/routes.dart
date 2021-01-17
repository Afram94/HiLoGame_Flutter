import 'package:flutter/material.dart';
import 'package:hilogame/views/login_screen.dart';
import 'package:hilogame/views/menu.dart';
import 'package:hilogame/views/opening_screen.dart';
import 'package:hilogame/views/play_screen.dart';
import 'package:hilogame/views/register_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String authLogin = "/auth-login";
  static const String authregister = "/auth-register";
  static const String menu = "/menu";
  static const String logout = "/auth-opening";
  static const String authPlay = "/auth-play";

  static Map<String, WidgetBuilder> define() {
    return {
      authLogin: (context) => Login(),
      authregister: (context) => Register(),
      menu: (context) => MenuScreen(),
      logout: (context) => OpeningView(),
      authPlay: (context) => PlayScreen(),
    };
  }
}
