import 'package:demo_navigator/constants/shared_preference_constant.dart';
import 'package:demo_navigator/data/remote/category_service.dart';
import 'package:demo_navigator/share/model/category.dart';
import 'package:demo_navigator/utils/spref_util.dart';
import 'package:flutter/cupertino.dart';
abstract class ICategoriesListener {
  onLoadCategory(List<Category> categories);
}
class CategoryRepository{
  CategoryService _categoryService;

  CategoryRepository({@required CategoryService categoryService}) : _categoryService = categoryService;

  void getCategories(ICategoriesListener listener) async {
    var futureRes = _categoryService.getCategories();
    futureRes.then((res) async {
      var data = Category.listFromJson(res.data["value"]);
      if (listener != null) listener.onLoadCategory(data);
      SprefUtil.putObjectList(SharedPreferenceConstant.KEY_BOOK_CATEGORIES, data);
    });
  }
}