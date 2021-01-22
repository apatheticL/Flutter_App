import 'package:demo_navigator/share/model/book.dart';

abstract class IBookListListener {
  onLoadBooks(int categoryId, List<Book> recommendedBook);
}