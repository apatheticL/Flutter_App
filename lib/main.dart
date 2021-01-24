import 'package:flutter/material.dart';

import 'app.dart';
import 'utils/spref_util.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SprefUtil.getInstance();
  runApp(MyApp());
//  Wakelock.enable(); //TODO remove when release, this line keep screen awake when app running
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return App();
  }
}