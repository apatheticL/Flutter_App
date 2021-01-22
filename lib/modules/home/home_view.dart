import 'package:demo_navigator/base/base_widget.dart';
import 'package:demo_navigator/constants/route_constant.dart';
import 'package:demo_navigator/constants/shared_preference_constant.dart';
import 'package:demo_navigator/modules/home/home_bloc.dart';
import 'package:demo_navigator/share/widget/bottom_navigation_bar.dart';
import 'package:demo_navigator/utils/spref_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
      if(SprefUtil.getString(SharedPreferenceConstant.KEY_TOKEN).isEmpty){
        Navigator.pushReplacementNamed(context, RouteConstant.SIGN_IN);
      }
      return PageContainer(
        bloc: [
          Provider.value(value: HomeBloc(),)
        ],
        di: [],
        slidebar: null,
        child: HomeBody(),
        bottomNavigatorBar: BottomNavBar(),
      );
  }
}
class HomeBody extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }

}
class _HomeState extends State<HomeBody>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero,(){
        var bloc = Provider.of<HomeBloc>(context);
        bloc.getBookForHome();
    });
  }
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<HomeBloc>(context);
    return Container(

    );
  }

}