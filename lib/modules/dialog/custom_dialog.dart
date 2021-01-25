import 'package:bizbook_clone/constants/image_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title, decription, textButton, imageUrl;
  final Function callback;
  final isConfirmationDialog;
  final isVipGroupDialog;

  const CustomDialog(
      {@required this.title,
      @required this.decription,
      @required this.textButton,
      this.imageUrl,
      this.callback,
      this.isConfirmationDialog,
      this.isVipGroupDialog});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Consts.padding))),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              top: Consts.avatarRadius + Consts.padding,
              bottom: Consts.padding,
              left: Consts.padding,
              right: Consts.padding),
          margin: isVipGroupDialog
              ? EdgeInsets.only(top: 100)
              : EdgeInsets.only(top: Consts.padding),
          decoration: new BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(Consts.padding),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: const Offset(0, 10))
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                imageUrl,
                width: 150,
                height: 100,
              ),
              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black),
              ),
              Text(
                decription,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              FlatButton(
                child: Text(textButton.toUpperCase(),style: TextStyle(fontSize: 14),),
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Colors.pinkAccent)
                ),
                onPressed: callback,
              )
            ],
          ),
        )
      ],
    );
  }
}

class Consts {
  Consts._();

  static const double padding = 8.0;
  static const double avatarRadius = 46.0;
}
