import 'dart:async';

import 'package:bizbook_clone/base/base_bloc.dart';
import 'package:bizbook_clone/base/base_event.dart';
import 'package:bizbook_clone/constants/constants.dart';
import 'package:bizbook_clone/constants/route_constant.dart';
import 'package:bizbook_clone/constants/shared_preference_constant.dart';
import 'package:bizbook_clone/data/repository/user_repository.dart';
import 'package:bizbook_clone/events/login_events/enter_pass_event.dart';
import 'package:bizbook_clone/events/login_events/enter_phone_event.dart';
import 'package:bizbook_clone/events/login_events/login_event.dart';
import 'package:bizbook_clone/events/login_events/login_failed_event.dart';
import 'package:bizbook_clone/events/login_events/login_success_event.dart';
import 'package:bizbook_clone/share/model/user_data.dart';
import 'package:bizbook_clone/share/validations.dart';
import 'package:bizbook_clone/utils/reponse_error.dart';
import 'package:bizbook_clone/utils/spref_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends BaseBloc implements ILoginListener {
  UserRepository _repository;
  static LoginBloc _instance;
  BuildContext context;

  static LoginBloc getInstance({@required UserRepository repository}) {
    if (_instance == null){
      _instance = LoginBloc._internal(repository: repository);
    }
    return _instance;
  }
  LoginBloc._internal({@required UserRepository repository}){
    _repository = repository;
  }
  StreamController<String> _phoneSubject = BehaviorSubject<String>();
  Stream<String> get phoneStream => _phoneSubject.stream;
  StreamController<String> _passSubject = BehaviorSubject<String>();
  Stream<String> get passStream => _passSubject.stream;


  @override
  void dispatchEvent(BaseEvent event) {
    switch(event.runtimeType){
      case PassWordEvent:
        _handleEventPass(event);
        break;
      case PhoneEvent:
        _handleEventPhone(event);
        break;
      case LoginEvent:
        _handleEventLogin(event);
        break;
    }
  }
  checkLogin(){
    _repository.checkLogin(this);
  }
  @override
  void setContext(BuildContext context) {
    this.context = context;
  }

  @override
  onCheckLoginSuccess(LoginResult userData) {
      progressEvenSink.add(LoginSuccessEvent(userData));
  }

  @override
  onLoginFailed(RestError restError) {
      progressEvenSink.add(LoginFailedEvent(restError.message));
  }
  void signInAsGuest() {
    _repository.signIn(Constants.GUEST_USERNAME, Constants.GUEST_PASSWORD, this);
  }
  @override
  onSignInSuccess(LoginResult userData) {
    SprefUtil.putBool(SharedPreferenceConstant.KEY_IS_GUEST_USER, userData.userType == Constants.GUEST_USERTYPE);
    this.preLoadStaticData();
    Navigator.pushNamedAndRemoveUntil(context, RouteConstant.HOME, (Route<dynamic>route) => false);
  }
  void _handleEventPass(PassWordEvent event) {
    if(Validation.validatePass(event.pass)){
      _passSubject.sink.add(null);
    }else{
      _passSubject.sink.add("pass is invalid");
    }
  }

  void _handleEventPhone(PhoneEvent event) {
    if(Validation.validatePhone(event.phone)){
      _phoneSubject.sink.add(null);
    }else{
      _phoneSubject.sink.add("phone is invalid");
    }
  }

  void _handleEventLogin(LoginEvent event) {
    _repository.signIn(event.phone, event.pass, this);
  }
  @override
  dispose() {
    _phoneSubject.close();
    _passSubject.close();
    return super.dispose();
  }
}

