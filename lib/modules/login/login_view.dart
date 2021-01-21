import 'package:demo_navigator/base/base_event.dart';
import 'package:demo_navigator/data/remote/user_service.dart';
import 'package:demo_navigator/data/repository/user_repository.dart';
import 'package:demo_navigator/events/login_events/login_failed_event.dart';
import 'package:demo_navigator/events/login_events/login_success_event.dart';
import 'package:demo_navigator/modules/login/login_bloc.dart';
import 'package:demo_navigator/share/widget/bloc_listener.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        body: MultiProvider(
          providers: [
            Provider.value(value: UserService()),
            ProxyProvider<UserService, UserRepository>(
              update: (context, userService, previous) =>
                  UserRepository(userService: userService),
            ),
            ProxyProvider<UserRepository, LoginBloc>(
              update: (context, repository, previous) =>
                  LoginBloc.getInstance(repository: repository),
            )
          ],
          child: LoginWithFormWidget(),
        ),
      ),
    );
  }
}

class LoginWithFormWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginWithFormState();
  }
}

class _LoginWithFormState extends State<LoginWithFormWidget> {
  final TextEditingController _txtPhoneController = TextEditingController();
  final TextEditingController _txtPassController = TextEditingController();
  String messageError = "";
  bool passwordVisiable;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var bloc = Provider.of<LoginBloc>(context);
      bloc.setContext(context);
      bloc.checkLogin();
    });
  }

  void setStateTextError(String messError) {}

  _handleEventListener(BaseEvent event) {
    switch (event.runtimeType) {
      case LoginFailedEvent:
        LoginFailedEvent loginFailedEvent = event as LoginFailedEvent;
        messageError = loginFailedEvent.error;
        break;
      case LoginSuccessEvent:
        messageError = "";
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    LoginBloc bloc = Provider.of<LoginBloc>(context);
    return BlocListener(
      listener: _handleEventListener,
      child: Container(
        color: Colors.red,
        padding: EdgeInsets.all(24),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //drawable view for login
              ],
            ),
          ),
        ),
      ),
    );
  }
}
