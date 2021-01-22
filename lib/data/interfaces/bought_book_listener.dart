import 'package:demo_navigator/share/model/book.dart';

abstract class IBoughtBookListener {
  onLoadBoughtBook(List<Book> books);
}