import 'package:bizbook_clone/config/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageContainer extends StatelessWidget {
  final String title;
  final Widget child;
  final List<Widget> action;
  final List<SingleChildCloneableWidget> bloc;
  final List<SingleChildCloneableWidget> di;
  final Widget slidebar;
  final Widget bottomNavigatorBar;
  final Widget specialTitle;
  final bool canSearch;

  PageContainer({this.title,
    this.child,
    this.action,
    this.bloc,
    this.di,
    this.slidebar,
    this.bottomNavigatorBar,
    this.specialTitle,
    this.canSearch = false});

  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      body: MultiProvider(
        providers: [...di, ...bloc],
        child: SafeArea(
          bottom: false,
          child: Scaffold(
            key: _scaffoldKey,
            drawer: slidebar,
            appBar: AppBar(
              centerTitle: (this.title != null || this.specialTitle != null),
              title: _getAppbarTile(context),
              toolbarOpacity: 1,
              backgroundColor: Colors.white,
              leading: this.slidebar == null
              ? IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppColor.greyMain,
              ),
                onPressed: () => Navigator.pop(context,false),
            ):
              Container(
                child: IconButton(
                  icon: Image.asset('res/icons/icon_menu.png',
                  width: 20,
                      height: 25,
                      fit: BoxFit.fill,),
                  onPressed: ()=> _scaffoldKey.currentState.openDrawer(),
                ),
              ),
              actions: this.action,
            ),
            body: child,
            bottomNavigationBar: bottomNavigatorBar,
          ),
        ),
      ),
    );
  }

  Widget _getAppbarTile(BuildContext context) {
    if(this.specialTitle !=null){
      return this.specialTitle;
    }
    return this.title!=null ?_buildTitle():_buildSearchBox(context);

  }
  Widget _buildSearchBox(BuildContext context) {
    // create search box
    return null;
  }
  Text _buildTitle() {
    return Text(
      this.title,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: AppColor.blueMain,
          fontWeight: FontWeight.w600,
          fontSize: 17
      ),
    );
  }
}


