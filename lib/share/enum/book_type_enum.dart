class BookTypeEnum {
  static const int ALL_BOOK = 0;
  static const String ALL_BOOK_TEXT = 'Tất cả';
  static const int NEW_BOOK = 1;
  static const String NEW_BOOK_TEXT = 'Sách mới';
  static const int FAV_BOOK = 2;
  static const String FAV_BOOK_TEXT = 'Sách nổi bật';
  static const int PENDING_BOOK = 3;
  static const String PENDING_BOOK_TEXT = 'Sách sắp phát hành';
  static const int TOP_BOOK = 4;
  static const String TOP_BOOK_TEXT = 'Sách bán chạy';

  static getBookTypeName(int type) {
    switch (type) {
      case NEW_BOOK:
        return NEW_BOOK_TEXT;
      case FAV_BOOK:
        return FAV_BOOK_TEXT;
      case PENDING_BOOK:
        return PENDING_BOOK_TEXT;
      case TOP_BOOK:
        return TOP_BOOK_TEXT;
    }
  }
}
