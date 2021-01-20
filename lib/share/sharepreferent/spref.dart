import 'package:shared_preferences/shared_preferences.dart';

class SPref{
  static final SPref  instance = SPref._internal();
  SPref._internal();
  Future set(String key, String value) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, value);
  }
  Future get(String key) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.get(key);
  }
}