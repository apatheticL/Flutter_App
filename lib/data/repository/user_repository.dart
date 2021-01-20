import 'package:demo_navigator/constants/shared_preference_constant.dart';
import 'package:demo_navigator/data/remote/user_service.dart';
import 'package:demo_navigator/share/enum/user_type_enum.dart';
import 'package:demo_navigator/share/model/user_data.dart';
import 'package:demo_navigator/utils/reponse_error.dart';
import 'package:demo_navigator/utils/spref_util.dart';
import 'package:flutter/cupertino.dart';

abstract class ILoginListener{
  onSignInSuccess(LoginResult userData);
  onCheckLoginSuccess(LoginResult userData);
  onLoginFailed(RestError restError);
}


class UserRepository{
  UserService _userService;
  UserRepository({@required UserService userService}) : _userService = userService;
  void signIn(String email, String password, ILoginListener listener) async{
    SprefUtil.getInstance();
    var futureRes = _userService.signIn(email, password);
    futureRes.then((res) async{
      LoginResult loginResult = LoginResult.fromJson(res.data);
      if(!loginResult.success){
        listener.onLoginFailed(RestError(message: loginResult.message));
        return;
      }
      if(loginResult.userType == UserTypeEnum.ADMIN){
        listener.onLoginFailed(RestError(message: "Tài khoản không khả dụng."));
        return;
      }
      SprefUtil.putObject(SharedPreferenceConstant.KEY_LOGIN_DATA, loginResult);
      SprefUtil.putString(SharedPreferenceConstant.KEY_TOKEN, loginResult.token);
      SprefUtil.putInt(SharedPreferenceConstant.KEY_USER_ID, loginResult.userId);
      SprefUtil.putString(SharedPreferenceConstant.KEY_USERNAME, email);
      SprefUtil.putString(SharedPreferenceConstant.KEY_PASSWORD, password);
      listener.onSignInSuccess(loginResult);
      var resUser = _userService.getUserInfo(loginResult.userId);
      resUser.then((res) async{
        SprefUtil.putObject(SharedPreferenceConstant.KEY_USER, res.data);
      });
    }).catchError((error) {
      listener.onLoginFailed(RestError(message: "thông tin đăng nhập không chính sác"));
    });
  }
}