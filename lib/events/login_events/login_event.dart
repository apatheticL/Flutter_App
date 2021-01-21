import 'package:demo_navigator/base/base_event.dart';

class LoginEvent extends BaseEvent{
  String phone;
  String pass;
  LoginEvent(this.phone, this.pass);
}