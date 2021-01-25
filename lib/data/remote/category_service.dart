import 'package:bizbook_clone/constants/api_constant.dart';
import 'package:bizbook_clone/data/network/networks.dart';
import 'package:dio/dio.dart';

class CategoryService {
  Future<Response> getCategories() {
    return BookClient.instance.dio.get(APIConstant.GET_CATEGORY);
  }
}