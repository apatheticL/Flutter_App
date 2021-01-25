import 'package:bizbook_clone/share/model/vip_group.dart';

import 'District.dart';
import 'city.dart';

class User {
  int id;
  String fullName;
  String customerCode;
  int status;
  String phoneNumber;
  String email;
  String birthDay;
  int point;
  int cityId;
  bool isUpdatedUserInfo;
  int districtId;
  String imgUser;
  String address;
  int currentVipGroupId;
  String totalAmount;
  City currentCity;
  District currentDistrict;
  int referralCount;
  int pointRanking;
  int boughtCount;
  int userType;
  VipGroup vipGroup;
  String referralCode;

  User(
      {this.id,
        this.fullName,
        this.customerCode,
        this.status,
        this.phoneNumber,
        this.email,
        this.birthDay,
        this.point,
        this.cityId,
        this.districtId,
        this.imgUser,
        this.address,
        this.currentVipGroupId,
        this.totalAmount,
        this.referralCount,
        this.boughtCount,
        this.currentCity,
        this.vipGroup,
        this.pointRanking,
        this.userType,
        this.currentDistrict,
        this.referralCode});

  User.fromJson(Map<String, dynamic> json) {
    id = json["Id"];
    fullName = json["FullName"];
    imgUser = json["Avatar"];
    currentVipGroupId = json["CurrentVipGroupId"];
    totalAmount = json["TotalAmount"];
    customerCode = json["Code"];
    status = json["Status"];
    email = json["Email"];
    phoneNumber = json["Tel"];
    birthDay = json["DateOfBirth"];
    cityId = json["CityId"];
    districtId = json["DistrictId"];
    address = json["Address"];
    isUpdatedUserInfo = !json["IsMissedInfomation"];
    referralCount = json['ReferralCount'];
    boughtCount = json['BoughtCount'];
    pointRanking = json['PointRanking'];
    userType = json['UserType'];
    referralCode = json['ReferralCode'];

    if (json['City'] != null) {
      currentCity = City.fromJson(json['City']);
    }
    if (json['District'] != null) {
      currentDistrict = District.fromJson(json['District']);
    }
    if (json['VipGroup'] != null) {
      vipGroup = VipGroup.fromJson(json['VipGroup']);
    }
    point = 100;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['FullName'] = this.fullName;
    data['Avatar'] = this.imgUser;
    data['CurrentVipGroupId'] = this.currentVipGroupId;
    data['TotalAmount'] = this.totalAmount;
    data['Code'] = this.customerCode;
    data['Status'] = this.status;
    data['Email'] = this.email;
    data['Tel'] = this.phoneNumber;
    data['DateOfBirth'] = this.birthDay;
    data['CityId'] = this.cityId;
    data['DistrictId'] = this.districtId;
    data['IsMissedInfomation'] = !this.isUpdatedUserInfo;
    data['Address'] = this.address;
    data['ReferralCount'] = this.referralCount;
    data['BoughtCount'] = this.boughtCount;
    data['VipGroup'] = this.vipGroup;
    data['PointRanking'] = this.pointRanking;
    data['ReferralCode'] = this.referralCode;
  }

  static List<User> listFromJson(List<dynamic> list) {
    List<User> rows = list.map((i) => User.fromJson(i)).toList();
    return rows;
  }
}