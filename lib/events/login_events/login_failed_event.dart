import 'package:bizbook_clone/base/base_event.dart';

class LoginFailedEvent extends BaseEvent{
  String error;
  LoginFailedEvent(this.error);
}