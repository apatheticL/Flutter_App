import 'package:bizbook_clone/base/base_widget.dart';
import 'package:bizbook_clone/constants/route_constant.dart';
import 'package:bizbook_clone/constants/shared_preference_constant.dart';
import 'package:bizbook_clone/modules/home/home_bloc.dart';
import 'package:bizbook_clone/modules/home/item_book/item_book_view.dart';
import 'package:bizbook_clone/share/arguments/list_book_argument.dart';
import 'package:bizbook_clone/share/enum/book_type_enum.dart';
import 'package:bizbook_clone/share/model/book.dart';
import 'package:bizbook_clone/share/widget/bottom_navigation_bar.dart';
import 'package:bizbook_clone/share/widget/divider_widget.dart';
import 'package:bizbook_clone/share/widget/loading_indicator.dart';
import 'package:bizbook_clone/utils/spref_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (SprefUtil.getString(SharedPreferenceConstant.KEY_TOKEN).isEmpty) {
      Navigator.pushReplacementNamed(context, RouteConstant.SIGN_IN);
    }
    return PageContainer(
      bloc: [
        Provider.value(
          value: HomeBloc(),
        )
      ],
      di: [],
      slidebar: null,
      child: HomeBody(),
      bottomNavigatorBar: BottomNavBar(
        currentIndex: 0,
      ),
    );
  }
}

class HomeBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomeBody> {
  static double homeContainerPadding = 15;
  static double homeContainerWidthPadding = homeContainerPadding * 2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      var bloc = Provider.of<HomeBloc>(context);
      bloc.getBookForHome();
    });
  }

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<HomeBloc>(context);
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  // drawable line black
                  _buildHeaderCategory(context, BookTypeEnum.NEW_BOOK_TEXT,
                      BookTypeEnum.NEW_BOOK),
                  _buildListBook(bloc.newBookStream, "newBook", bloc),
                  DividerWidget(
                    paddingVertical: 8,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Container _buildHeaderCategory(
      BuildContext context, String headerTitle, int type) {
    return Container(
      height: 48,
      padding:
          EdgeInsets.fromLTRB(homeContainerPadding, 0, homeContainerPadding, 0),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: <Widget>[
          Text(
            headerTitle.toUpperCase(),
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
          Expanded(
            flex: 3,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(RouteConstant.BOOK_LIST,
                    arguments: new BookListArgument(type, null));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "Xem tất cả",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 14, color: Colors.cyan),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.blueAccent,
                    size: 14,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  StreamProvider<List<Book>> _buildListBook(
      Stream newBookStream, String s, HomeBloc bloc) {
    return StreamProvider<List<Book>>.value(
      value: newBookStream,
      initialData: [],
      child: Consumer<List<Book>>(
        builder: (context, data, child) {
          if (data == null) return LoadingIndicatorWidget();
          if (data.length == 0) return Container();
          return Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(
                homeContainerPadding, 0, homeContainerPadding - 5, 0),
            child: Wrap(
              children: List.generate(data.length, (index){
                data[index].keyTag  = data[index].id.toString()+s;
                return Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: new ItemBookWidget(bloc: bloc, size: (MediaQuery.of(context).size.width -
                      homeContainerWidthPadding) /
                      3, book: data[index]),
                );
              }),
            ),
          );
        },
      ),
    );
  }
}
