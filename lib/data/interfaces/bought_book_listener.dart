import 'package:bizbook_clone/share/model/book.dart';

abstract class IBoughtBookListener {
  onLoadBoughtBook(List<Book> books);
}