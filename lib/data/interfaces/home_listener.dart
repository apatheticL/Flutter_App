import 'package:demo_navigator/share/model/book.dart';

abstract class IHomeListener {
  onLoadNewBook(List<Book> books);
  onLoadTopBook(List<Book> books);

  onLoadFavouriteBook(List<Book> books);

  onLoadPendingBook(List<Book> books);

}