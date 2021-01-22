class APIConstant{
  static const BASE_URL = "https://odata.bizbooks.vn/";
  static const EXTERNAL_VIP =
      "https://kong.mcbooks.vn/production/vip-externalsv/";
  static const UPLOAD_FILE = "https://file-retail.mcbooks.vn/upload";
  static const LOGIN = "login";
  static const GET_CATEGORY="Categories?\$count=true&\$orderby=No&\$filter=Visible eq true";


  static const GET_BOOK = "Books?\$count=true";
  static const GET_BOUGHT_BOOK =
      "Books/Mcbook.searchBoughtBookByMemberId(UserId=0)";
  static const GET_RESERVED_BOOK = "Books/Mcbook.getReservedBookList(UserId=0)";
  static const GET_NEW_BOOK = "Books?\$count=true";
  static const GET_TOP_BOOK = "Books?\$count=true";
  static const GET_FAV_BOOK = "Books?\$count=true";
  static const GET_PENDING_BOOK = "Books?\$count=true";
  static const GET_BOOK_DETAIL = "Books";
  static const GET_RELATED_BOOK = "Books/Mcbook.searchRelatedBook(BookId={0})";
  static const GET_BOOK_BY_IDS = "Books/Mcbook.getListBook(Ids='{0}')";
  static const ADD_BOOK_TO_ORDER = "Orders/Mcbook.addToCart";
  static const ADD_BOOK_TO_PRE_ORDER = "Orders/Mcbook.addBookToReserveOrder";
  static const GET_BANNER_IMAGES = "Slides?\$count=true";
  static const SEARCH_BOOK = "Books/Mcbook.searchBookWithFilter";
  static const GET_USER = 'Users?\$count=true';
  static const GET_CITY = 'v_city?\$count=true';
  static const GET_DISTRICT = 'v_district?\$count=true';
  static const GET_NOTIFICATION =
      'Notifications?\$count=true&\$filter=UserNotifications/any(x:x/UserId eq 1178) and Type eq 1';
  static const GET_CUSTOMER = 'Users?\$filter=';

  static const GET_ORDER =
      "Orders?\$filter=UserId eq {0} and Status eq {1}{2}&\$expand=OrderDetails,VipGroup&\$orderby=CreatedAt desc";
  static const GET_VIP_GROUP =
      "VipGroups?\$select=Id,Name,Description,Discount,Amount,IconUrl&\$filter=Status eq 1";
  static const GET_ORDER_WITH_DETAIL =
      'Orders?\$filter=UserId eq {0} and Status eq 0&\$expand=OrderDetails,VipGroup,User(\$expand=City(\$expand=v_district),District)';
  static const GET_RESERVED_ORDER_WITH_DETAIL =
      'Orders?\$filter=UserId eq {0} and Status eq -3 and ReservedOrder eq true&\$expand=OrderDetails,VipGroup,User(\$expand=City(\$expand=v_district),District)';
  static const PAY_RESERVED_ORDER =
      'Orders/Mcbook.paymentForReservedOrder(OrderId={0},CityId={1},DistrictId={2},Address=\'{3}\',ContactName=\'{4}\',Tel=\'{5}\',Note=\'{6}\')';
  static const BUY_VIP_GROUP = 'sendNotifyAboutRecharge';

  static const UPDATE_ORDER_DETAIL_QTY = 'OrderDetails({0})';
  static const UPDATE_PRE_ORDER_DETAIL_QTY =
      'OrderDetails/Mcbook.updateQuantityReservedBook(Key={0},Quantity={1})';
  static const DELETE_ORDER_DETAIL = 'OrderDetails({0})';

  static const GET_SUGGESTION_BOOKS =
      'Books/Mcbook.searchSuggestion(Keyword=\'{0}\',Take={1})';
  static String buildSearchBookQuery({
    int categoryId,
    bool isHotDeal = false,
    bool isHotSale = false,
    bool isNew = false,
    bool isComingSoon = false,
    bool isFamous = false,
    int skip = 0,
    int take = 12,
    String searchKey,
  }) {
    String url = "Books/Mcbook.searchBookWithFilter(";
    var sb = StringBuffer(url);
    if (categoryId != null) sb.write("CategoryId=$categoryId,");
    if (isHotDeal) sb.write("IsHotDeal=$isHotDeal,");
    if (isHotSale) sb.write("IsHotSale=$isHotSale,");
    if (isNew) sb.write("IsNew=$isNew,");
    if (isComingSoon) sb.write("IsComingSoon=$isComingSoon,");
    if (isFamous) sb.write("IsFamous=$isFamous,");
    if (searchKey != null) sb.write("SearchKey='$searchKey',");
    sb.write("Skip=$skip,");
    sb.write("Take=$take");
    sb.write(")");
    return sb.toString();
  }
}