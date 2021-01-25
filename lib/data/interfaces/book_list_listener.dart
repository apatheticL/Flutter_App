import 'package:bizbook_clone/share/model/book.dart';

abstract class IBookListListener {
  onLoadBooks(int categoryId, List<Book> recommendedBook);
}