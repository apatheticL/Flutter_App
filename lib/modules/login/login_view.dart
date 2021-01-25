import 'package:bizbook_clone/base/base_event.dart';
import 'package:bizbook_clone/config/app_color.dart';
import 'package:bizbook_clone/constants/image_constant.dart';
import 'package:bizbook_clone/constants/route_constant.dart';
import 'package:bizbook_clone/data/remote/user_service.dart';
import 'package:bizbook_clone/data/repository/user_repository.dart';
import 'package:bizbook_clone/events/login_events/enter_pass_event.dart';
import 'package:bizbook_clone/events/login_events/enter_phone_event.dart';
import 'package:bizbook_clone/events/login_events/login_event.dart';
import 'package:bizbook_clone/events/login_events/login_failed_event.dart';
import 'package:bizbook_clone/events/login_events/login_success_event.dart';
import 'package:bizbook_clone/modules/login/login_bloc.dart';
import 'package:bizbook_clone/share/widget/bloc_listener.dart';
import 'package:bizbook_clone/share/widget/normal_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
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
    return BlocListener<LoginBloc>(
      listener: _handleEventListener,
      child: Container(
        color: Colors.blueGrey,
        padding: EdgeInsets.all(24),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //drawable view for login
                Center(
                  child: Image.asset("res/images/welcomeLogo.png", width: 100,
                    height: 100,),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color:  Colors.black38,
                    border: Border.all(color: Colors.white,width: 1),
                    borderRadius: BorderRadius.circular(16.0)
                  ),
                  child: _buildUsernameField(bloc),
                  padding: EdgeInsets.only(left: 8),
                ),

                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      color:  Colors.black38,
                      border: Border.all(color: Colors.white,width: 1),
                      borderRadius: BorderRadius.circular(16.0)
                  ),
                  child: _buildPassField(bloc),
                  padding: EdgeInsets.only(left: 8,right: 8),
                ),
                SizedBox(height: 24,),
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

              ],
            ),
          ),
        ),)
      ,
    );
  }

  Widget _buildUsernameField(LoginBloc bloc) {
    return
      StreamBuilder(
      stream: bloc.phoneStream,
      initialData: null,
      builder: (context, AsyncSnapshot<String> textStream) =>
          TextField(
            controller: _txtPhoneController,
            onChanged: (text) {
              bloc.progressEvenSink.add(PhoneEvent(text));
            },
            cursorColor: Colors.white30,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.transparent,
                icon: Image.asset(
                  ImageConstant.ICON_EMAIL, width: 25, height: 25,),
                hintText: 'Email',
                hintStyle: TextStyle(color: Colors.white,),
                contentPadding: const EdgeInsets.only(
                    left: 14, bottom: 8, top: 8),
                // focusedBorder: OutlineInputBorder(
                //     borderRadius: BorderRadius.circular(16),
                //     borderSide: BorderSide(color: Colors.white)
                // ),
                // enabledBorder: UnderlineInputBorder(
                //     borderSide: BorderSide(color: Colors.redAccent),
                //     borderRadius: BorderRadius.circular(16)
                // )
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
                  top: 20,
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
        backgroundColor: Colors.black54,
        color:Colors.white);
  }


}
