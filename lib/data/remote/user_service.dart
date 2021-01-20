import 'dart:convert';

import 'package:demo_navigator/constants/api_constant.dart';
import 'package:demo_navigator/data/network/networks.dart';
import 'package:dio/dio.dart';

class UserService{
    // sign in
  Future<Response> signIn(String email, String pass){
    var jsonData={
      'email':email,
      'password':pass,
    };
    return BookClient.instance.dio.post(APIConstant.LOGIN,data: json.encode(jsonData));
  }
  Future<Response> register(
        String username, String email, String phone,String password,String confiramationCode
      ){
    return BookClient.instance.dio.post("Users/Mcbook.registerUser(FullName='$username',Email='$email',Password='$password',Tel='$phone',ReferralCode='$confiramationCode')");
  }
  Future<Response> getUserInfo(int id) {
    return BookClient.instance.dio.get('Users($id)?\$expand=City,District,VipGroup');
  }
}