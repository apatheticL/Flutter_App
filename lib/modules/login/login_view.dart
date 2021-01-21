import 'package:demo_navigator/base/base_event.dart';
import 'package:demo_navigator/config/app_color.dart';
import 'package:demo_navigator/constants/image_constant.dart';
import 'package:demo_navigator/constants/route_constant.dart';
import 'package:demo_navigator/data/remote/user_service.dart';
import 'package:demo_navigator/data/repository/user_repository.dart';
import 'package:demo_navigator/events/login_events/enter_pass_event.dart';
import 'package:demo_navigator/events/login_events/enter_phone_event.dart';
import 'package:demo_navigator/events/login_events/login_event.dart';
import 'package:demo_navigator/events/login_events/login_failed_event.dart';
import 'package:demo_navigator/events/login_events/login_success_event.dart';
import 'package:demo_navigator/modules/login/login_bloc.dart';
import 'package:demo_navigator/share/widget/bloc_listener.dart';
import 'package:demo_navigator/share/widget/normal_button.dart';
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
                Center(
                  child: Image.asset("res\images\logo_app.png", width: 100,
                    height: 100,),
                ),
                SizedBox(
                  height: 20,
                ),
                _buildUsernameField(bloc),
                SizedBox(
                  height: 20,
                ),
                _buildPassField(bloc),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        child: Text(
                          'Quên mật khẩu?',
                          style: TextStyle(
                            color: AppColor.white,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        onTap: () {
                           //TODO open screen forgot pass
                        },
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          //TODO open screen register
                        },
                        child: Text(
                          'Đăng ký tài khoản',
                          style: TextStyle(
                            color: AppColor.white,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 80,
                ),
                buildSignInButton(bloc),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        bloc.signInAsGuest();
//                          Navigator.push(
//                              context, MaterialPageRoute(builder: (context) => RegisterPage()));
                      },
                      child: Container(
                        child: Text(
                          'Đăng nhập sau',
                          style: TextStyle(
                            color: AppColor.white,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    )
                  ],
                ),
                _buildFooter(context, bloc),
              ],
            ),
          ),
        ),)
      ,
    );
  }

  Widget _buildUsernameField(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.phoneStream,
      initialData: null,
      builder: (context, AsyncSnapshot<String> textStream) =>
          TextField(
            controller: _txtPhoneController,
            onChanged: (text) {
              bloc.progressEvenSink.add(PhoneEvent(text));
            },
            cursorColor: AppColor.white,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              fontSize: 14,
              color: AppColor.white,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
                filled: true,
                fillColor: AppColor.white,
                icon: Image.asset(
                  ImageConstant.ICON_EMAIL, width: 25, height: 25,),
                hintText: 'Email',
                hintStyle: TextStyle(color: AppColor.white,),
                contentPadding: const EdgeInsets.only(
                    left: 14, bottom: 8, top: 8),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Colors.white)
                ),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.redAccent),
                    borderRadius: BorderRadius.circular(16)
                )
            ),
          ),
    );
  }

  Widget _buildPassField(LoginBloc bloc) {
    return StreamProvider<String>.value(
      value: bloc.passStream,
      initialData: null,
      child: Consumer<String>(
        builder: (context, msg, child) =>
            Stack(
              children: <Widget>[
                TextField(
                  controller: _txtPassController,
                  onChanged: (text) {
                    bloc.progressEvenSink.add(PassWordEvent(text));
                  },
                  obscureText: !(passwordVisiable ?? false),
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 14, color: AppColor.white, fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: false,
                    icon: Image.asset(ImageConstant.ICON_LOCK,width: 25, height: 25,),
                    hintText: "Password",
                    hintStyle: TextStyle(
                      color: AppColor.white
                    )
                  ),
                ),
                Positioned(
                  right: 0,
                  left: 20,
                  child: Container(
                    height: 15,
                    child: Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          child: Image.asset(
                            'res/icons/icon_password_view.png',
                            height: 15,
                          ),
                          onTapDown: (TapDownDetails x) {
                            setState(() {
                              passwordVisiable = true;
                            });
                          },
                          onTapUp: (x) {
                            setState(() {
                              passwordVisiable = false;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
      ),
    );
  }
  Widget buildSignInButton(LoginBloc bloc) {
    return NormalButton(
        title: 'ĐĂNG NHẬP',
        onPressed: () {
          bloc.progressEvenSink
              .add(LoginEvent(_txtPhoneController.text, _txtPassController.text));
        },
        backgroundColor: AppColor.white,
        color: AppColor.blueMain);
  }

  Widget _buildFooter(BuildContext context, LoginBloc bloc) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      padding: EdgeInsets.all(10),
      child: FlatButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, RouteConstant.REGISTER);
        },
        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(4.0)),
        child: Text(
          'Đăng ký tài khoản',
          style: TextStyle(color: AppColor.blueMain, fontSize: 19),
        ),
      ),
    );
  }
}
