import 'package:demo_navigator/constants/api_constant.dart';
import 'package:demo_navigator/data/network/networks.dart';
import 'package:dio/dio.dart';

class CategoryService {
  Future<Response> getCategories() {
    return BookClient.instance.dio.get(APIConstant.GET_CATEGORY);
  }
}