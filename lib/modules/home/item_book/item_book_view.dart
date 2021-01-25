import 'package:bizbook_clone/base/base_bloc.dart';
import 'package:bizbook_clone/share/model/book.dart';
import 'package:flutter/cupertino.dart';

class ItemBookWidget extends StatelessWidget{
  final BaseBloc bloc;
  final bool isListBook;
  final double size;
  final bool hasPrice;
  final Book book;

  const ItemBookWidget({Key key,@required this.bloc, this.isListBook,@required this.size, this.hasPrice,@required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return null;
  }
}