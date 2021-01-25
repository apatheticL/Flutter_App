import 'package:bizbook_clone/constants/shared_preference_constant.dart';
import 'package:bizbook_clone/data/remote/user_service.dart';
import 'package:bizbook_clone/share/enum/user_type_enum.dart';
import 'package:bizbook_clone/share/model/user.dart';
import 'package:bizbook_clone/share/model/user_data.dart';
import 'package:bizbook_clone/utils/reponse_error.dart';
import 'package:bizbook_clone/utils/spref_util.dart';
import 'package:flutter/cupertino.dart';

abstract class ILoginListener{
  onSignInSuccess(LoginResult userData);
  onCheckLoginSuccess(LoginResult userData);
  onLoginFailed(RestError restError);
}

abstract class IUserListener {
  onLoadUserInfo(User userData);
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
  void getUserInfo(IUserListener listener) async {
    var userId = SprefUtil.getInt(SharedPreferenceConstant.KEY_USER_ID);
    var futures = _userService.getUserInfo(userId);
    futures.then((res) {
      var data = User.fromJson(res.data);
      print('status' + data.status.toString());
      if (listener != null) listener.onLoadUserInfo(data);
      SprefUtil.putObject(SharedPreferenceConstant.KEY_USER, res.data);
    }).catchError((error) {
      print(error.toString());
    });
  }
  void checkLogin(ILoginListener listener) async {
    var username = SprefUtil.getString(SharedPreferenceConstant.KEY_USERNAME);

    var password = SprefUtil.getString(SharedPreferenceConstant.KEY_PASSWORD);
    //    username = SPref.instance.get(SPrefCacheConstant.KEY_USERNAME).toString();
    if (username == null || password == null) return;
    print(username);
    print(password);
    var futureRes = _userService.signIn(username, password);
    futureRes.then((res) async {
      LoginResult userData = LoginResult.fromJson(res.data);
      print("IsActive: ${userData.isActive}");
      if (!userData.success) {
        return;
      }
      SprefUtil.putString(SharedPreferenceConstant.KEY_TOKEN, userData.token);
      SprefUtil.putObject(SharedPreferenceConstant.KEY_LOGIN_DATA, userData);
      listener.onSignInSuccess(userData);
    });
  }
}