import 'package:bizbook_clone/base/base_bloc.dart';
import 'package:bizbook_clone/base/base_event.dart';
import 'package:bizbook_clone/data/interfaces/home_listener.dart';
import 'package:bizbook_clone/data/remote/book_service.dart';
import 'package:bizbook_clone/data/repository/home_repository.dart';
import 'package:bizbook_clone/share/model/book.dart';
import 'package:bizbook_clone/share/widget/bloc_listener.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BaseBloc implements IHomeListener {
  BookRepository repository = BookRepository(bookService: BookService());
  List<Book> favouriteBook;
  List<Book> newBook;
  List<Book> topSellerBook;
  List<Book> pendingBook;
  final favouriteBookCtrol = BehaviorSubject<List<Book>>();
  final newBookCtrol = BehaviorSubject<List<Book>>();
  final topSellerBookCtrol = BehaviorSubject<List<Book>>();
  final pendingBookCtrol = BehaviorSubject<List<Book>>();

  get favouriteBookStream => favouriteBookCtrol.stream;

  get newBookStream => newBookCtrol.stream;

  get topSellerBookStream => topSellerBookCtrol.stream;

  get pendingBookStream => pendingBookCtrol.stream;

  getBookForHome() {
    repository.getBooksForHome(this);
  }

  @override
  dispose() {
    favouriteBookCtrol.close();
    newBookCtrol.close();
    topSellerBookCtrol.close();
    pendingBookCtrol.close();
    super.dispose();
  }

  @override
  void dispatchEvent(BaseEvent event) {}

  @override
  onLoadFavouriteBook(List<Book> books) {
    if(books!=null  && books.length >6)books = books.getRange(0, 6).toList();
    favouriteBookCtrol.sink.add(books);
  }

  @override
  onLoadNewBook(List<Book> books) {
    if(books!=null  && books.length >6)books = books.getRange(0, 6).toList();
    newBookCtrol.sink.add(books);
  }

  @override
  onLoadPendingBook(List<Book> books) {
    if(books!=null  && books.length >6)books = books.getRange(0, 6).toList();
    pendingBookCtrol.sink.add(books);
  }

  @override
  onLoadTopBook(List<Book> books) {
    if(books!=null  && books.length >6)books = books.getRange(0, 6).toList();
    topSellerBookCtrol.sink.add(books);
  }
}
