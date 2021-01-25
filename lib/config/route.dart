
import 'package:bizbook_clone/constants/route_constant.dart';
import 'package:bizbook_clone/modules/login/login_view.dart';
import 'package:bizbook_clone/modules/home/home_view.dart';
import 'package:bizbook_clone/modules/order/order_view.dart';
import 'package:bizbook_clone/modules/person/personal_view.dart';

import 'package:flutter/material.dart';


Map<String, WidgetBuilder> routeConfig() {
  return <String, WidgetBuilder>{
    RouteConstant.SIGN_IN: (context) => LoginScreen(),
    RouteConstant.HOME: (context) => HomeView(),
    RouteConstant.ORDER: (context) => OrderView(),
    RouteConstant.PERSON: (context) => PersonalView(),
  };
}
