import 'package:bizbook_clone/config/layout.dart';
import 'package:bizbook_clone/constants/api_constant.dart';
import 'package:bizbook_clone/data/network/networks.dart';
import 'package:dio/dio.dart';

class BookService {
  Future<Response> getBooks({int categoryId, int skip, String keywords}) {
    return BookClient.instance.dio.get(
        APIConstant.buildSearchBookQuery(categoryId: categoryId, skip: skip, searchKey: keywords));
  }

  Future<Response> getNewBooks({int categoryId, int skip, String keywords}) {
    return BookClient.instance.dio.get(APIConstant.buildSearchBookQuery(
        isNew: true, categoryId: categoryId, skip: skip, searchKey: keywords));
  }

  Future<Response> getTopBooks({int categoryId, int skip, String keywords}) {
    return BookClient.instance.dio.get(APIConstant.buildSearchBookQuery(
        isHotSale: true, categoryId: categoryId, skip: skip, searchKey: keywords));
  }

  Future<Response> getPendingBooks({int categoryId = 0, int skip, String keywords}) {
    return BookClient.instance.dio.get(APIConstant.buildSearchBookQuery(
        isComingSoon: true, categoryId: categoryId, skip: skip, searchKey: keywords));
  }

  Future<Response> getFavouriteBooks({int categoryId, int skip, String keywords}) {
    return BookClient.instance.dio.get(APIConstant.buildSearchBookQuery(
        isFamous: true, categoryId: categoryId, skip: skip, searchKey: keywords));
  }

  Future<Response> getBoughtBook(int userId) {
    return BookClient.instance.dio
        .get(APIConstant.GET_BOUGHT_BOOK.replaceAll('0', userId.toString()));
  }

  Future<Response> getSliderUrls() {
    return BookClient.instance.dio.get(APIConstant.GET_BANNER_IMAGES);
  }

  Future<Response> searchSuggestionBooks(String keyword) {
    return BookClient.instance.dio.get(APIConstant.GET_SUGGESTION_BOOKS
        .replaceAll('{0}', keyword)
        .replaceAll("{1}", LayoutConfig.SEARCH_SUGGESTION_MAX.toString()));
//        APIConstant.buildSearchBookQuery(isNew: true, categoryId: 0, take: 5));
  }

  Future<Response> getRecommendedBook(int bookId) {
    return BookClient.instance.dio
        .get(APIConstant.GET_RELATED_BOOK.replaceAll('{0}', bookId.toString()));
  }

  Future<Response> getDetailBook(int bookId) {
    return BookClient.instance.dio.get(APIConstant.GET_BOOK_DETAIL + "($bookId)");
  }

  Future<Response> addBookToCart(int bookId, int qty, int userId) {
    return BookClient.instance.dio
        .get(APIConstant.ADD_BOOK_TO_ORDER + "(UserId=$userId,BookId=$bookId,Quantity=$qty)");
  }

  Future<Response> getBooksByIds(List<String> lastIds) {
    lastIds.join(",");
    var sb = StringBuffer(APIConstant.GET_BOOK_BY_IDS.replaceAll("{0}", lastIds.join(",")));
    return BookClient.instance.dio.get(sb.toString());
  }

  Future<Response> addBookToPreOrder(int bookId, int userId) {
    return BookClient.instance.dio
        .get(APIConstant.ADD_BOOK_TO_PRE_ORDER + "(UserId=$userId,BookId=$bookId,Quantity=1)");
  }

  Future<Response> getReservedBooks(int userId) {
    return BookClient.instance.dio
        .get(APIConstant.GET_RESERVED_BOOK.replaceAll('0', userId.toString()));
  }
}