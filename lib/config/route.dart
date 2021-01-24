import 'package:demo_navigator/constants/route_constant.dart';
import 'package:demo_navigator/modules/home/home_view.dart';
import 'package:demo_navigator/modules/login/login_view.dart';
import 'package:flutter/material.dart';


Map<String, WidgetBuilder> routeConfig() {
  return <String, WidgetBuilder>{
    RouteConstant.SIGN_IN: (context) => LoginScreen(),
    RouteConstant.HOME: (context) => HomeView(),

  };
}
