import 'package:bizbook_clone/base/base_event.dart';
import 'package:bizbook_clone/share/model/user_data.dart';

class LoginSuccessEvent extends BaseEvent{
  LoginResult userResult;
  LoginSuccessEvent(this.userResult);
}