import 'package:bizbook_clone/constants/shared_preference_constant.dart';
import 'package:bizbook_clone/data/interfaces/book_list_listener.dart';
import 'package:bizbook_clone/data/interfaces/bought_book_listener.dart';
import 'package:bizbook_clone/data/interfaces/home_listener.dart';
import 'package:bizbook_clone/data/remote/book_service.dart';
import 'package:bizbook_clone/share/enum/book_type_enum.dart';
import 'package:bizbook_clone/share/model/book.dart';
import 'package:bizbook_clone/utils/spref_util.dart';
import 'package:bizbook_clone/utils/unicode_character_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class BookRepository {
  BookService _bookService;

  BookRepository({@required BookService bookService}) : _bookService = bookService;

  void getBooksForHome(IHomeListener listener) async {
    // UserData userData = UserData(avatar: null, displayName: 'aaaa', token: '92839189');
    // signInListener.onSignInSuccess(userData);
    var futureRes = _bookService.getNewBooks();
    futureRes.then((res) {
      var data = Book.listFromJson(res.data["value"]);
      listener.onLoadNewBook(data);
    });

    var fav = _bookService.getFavouriteBooks();
    fav.then((res) {
      var data = Book.listFromJson(res.data["value"]);
      listener.onLoadFavouriteBook(data);
    });

    var top = _bookService.getTopBooks();
    top.then((res) {
      var data = Book.listFromJson(res.data["value"]);
      listener.onLoadTopBook(data);
    });

    var pending = _bookService.getPendingBooks();
    pending.then((res) {
      var data = Book.listFromJson(res.data["value"]);
      listener.onLoadPendingBook(data);
    });

    // var sliderUrls = _bookService.getSliderUrls();
    // sliderUrls.then((res) {
    //   var data = HomeSlider.listFromJson(res.data["value"]);
    //   listener.onloadSliderUrls(data);
    // });
  }

  void getBoughtBook(IBoughtBookListener listener) {
    var books = _bookService.getBoughtBook(
        SprefUtil.getInt(SharedPreferenceConstant.KEY_USER_ID));
    books.then((res) {
      var data = Book.listFromJson(res.data["value"]);
      listener.onLoadBoughtBook(data);
    }).catchError((error) => print("Error: " + error.toString()));
  }

  void getListBooks(int type, int categoryId, IBookListListener listener,
      String keywords,
      {int skip}) {
    Future<Response> books;
    keywords = VNCharacterUtils.removeAccent(keywords);
    switch (type) {
      case BookTypeEnum.ALL_BOOK:
        books = _bookService.getBooks(
            categoryId: categoryId, skip: skip, keywords: keywords);
        break;
      case BookTypeEnum.NEW_BOOK:
        books = _bookService.getNewBooks(
            categoryId: categoryId, skip: skip, keywords: keywords);
        break;
      case BookTypeEnum.FAV_BOOK:
        books =
            _bookService.getFavouriteBooks(
                categoryId: categoryId, skip: skip, keywords: keywords);
        break;
      case BookTypeEnum.PENDING_BOOK:
        books =
            _bookService.getPendingBooks(
                categoryId: categoryId, skip: skip, keywords: keywords);
        break;
      case BookTypeEnum.TOP_BOOK:
        books = _bookService.getTopBooks(
            categoryId: categoryId, skip: skip, keywords: keywords);
        break;
    }
    books.then((res) {
      var data = Book.listFromJson(res.data["value"]);
      listener.onLoadBooks(categoryId, data);
    }).catchError((error) => print("Error: " + error.toString()));
  }

}