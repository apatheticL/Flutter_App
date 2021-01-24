import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'config/route.dart';
import 'config/theme.dart';
import 'constants/route_constant.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Test',
        theme: themeConfig(),
        initialRoute: RouteConstant.SIGN_IN,
        routes: routeConfig());
  }
}