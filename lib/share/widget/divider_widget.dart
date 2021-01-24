import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget{
 final double paddingVertical;
 final double horizontalAspect;

  const DividerWidget({Key key, this.paddingVertical, this.horizontalAspect = 0.6}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Center(
     child: Container(
      padding: EdgeInsets.only(bottom: paddingVertical, top: paddingVertical),
      width: MediaQuery.of(context).size.width * horizontalAspect,
      child: Divider(
       color: Colors.grey[200],
       thickness: 2,
      ),
     ),
    );
  }
}