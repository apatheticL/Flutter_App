import 'package:demo_navigator/base/base_event.dart';
import 'package:demo_navigator/share/model/user_data.dart';

class LoginSuccessEvent extends BaseEvent{
  LoginResult userResult;
  LoginSuccessEvent(this.userResult);
}