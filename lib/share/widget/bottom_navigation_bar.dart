import 'package:demo_navigator/config/app_color.dart';
import 'package:demo_navigator/constants/dimen_constant.dart';
import 'package:demo_navigator/constants/image_constant.dart';
import 'package:demo_navigator/constants/route_constant.dart';
import 'package:demo_navigator/constants/string_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget{
  final int currentIndex;

  BottomNavBar({@required this.currentIndex, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 54,
      decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey[200],width: 1))),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        iconSize: DimenConstant.SIZE_ICON_BOTTOM_NAVIGATION,
        backgroundColor: Colors.white,
        fixedColor: Colors.red,
        unselectedItemColor: AppColor.blueMain,
        onTap: (selectIndex) {
          switch(selectIndex){
            case 0:
              if(ModalRoute.of(context).settings.name == RouteConstant.HOME) return;
              Navigator.pushNamedAndRemoveUntil(context, RouteConstant.HOME, (Route<dynamic> route) =>false);
              break;
            case 1:
              if (ModalRoute.of(context).settings.name == RouteConstant.PERSON) return;
              Navigator.pushNamedAndRemoveUntil(
                  context, RouteConstant.PERSON, (Route<dynamic> route) => false);
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.cyan,
            activeIcon: Image.asset(ImageConstant.ICON_HOME_SELECTED , height:DimenConstant.SIZE_ICON_BOTTOM_NAVIGATION,),
            title: Text(StringConstant.TITLE_HOME_BOTTOM_NV, style: TextStyle(fontSize: 12),),
            icon: Image.asset(ImageConstant.IMAGE_HOME, height: DimenConstant.SIZE_ICON_BOTTOM_NAVIGATION,)
          ),
          BottomNavigationBarItem(
              backgroundColor: Colors.cyan,
              activeIcon: Image.asset(ImageConstant.ICON_SHOPPING_CART_MAIN_SELECTED , height:DimenConstant.SIZE_ICON_BOTTOM_NAVIGATION,),
              title: Text(StringConstant.TITLE_CART_HOME_BOTTOM_NV, style: TextStyle(fontSize: 12),),
              icon: Image.asset(ImageConstant.ICON_SHOPPING_CART_MAIN, height: DimenConstant.SIZE_ICON_BOTTOM_NAVIGATION,)
          ),
          BottomNavigationBarItem(
              backgroundColor: Colors.cyan,
              activeIcon: Image.asset(ImageConstant.ICON_USER_SELECTED , height:DimenConstant.SIZE_ICON_BOTTOM_NAVIGATION,),
              title: Text(StringConstant.TITLE_PROFILE_BOTTOM_NV, style: TextStyle(fontSize: 12),),
              icon: Image.asset(ImageConstant.ICON_USER_, height: DimenConstant.SIZE_ICON_BOTTOM_NAVIGATION,)
          )
        ],
      ),
    );
  }

}