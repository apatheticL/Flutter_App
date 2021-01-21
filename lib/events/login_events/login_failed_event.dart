import 'package:demo_navigator/base/base_event.dart';

class LoginFailedEvent extends BaseEvent{
  String error;
  LoginFailedEvent(this.error);
}