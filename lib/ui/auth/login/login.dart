import 'package:another_flushbar/flushbar_helper.dart';
import 'package:safewalk/constants/assets.dart';
import 'package:safewalk/constants/colors.dart';
import 'package:safewalk/data/sharedpref/constants/preferences.dart';
import 'package:safewalk/stores/user/user_store.dart';
import 'package:safewalk/utils/routes/routes.dart';
import 'package:safewalk/stores/form/form_store.dart';
import 'package:safewalk/stores/theme/theme_store.dart';
import 'package:safewalk/utils/device/device_utils.dart';
import 'package:safewalk/utils/locale/app_localization.dart';
import 'package:safewalk/widgets/empty_app_bar_widget.dart';
import 'package:safewalk/widgets/progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //text controllers:-----------------------------------------------------------
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  //stores:---------------------------------------------------------------------
  late ThemeStore _themeStore;
  late UserStore _userStore;

  //focus node:-----------------------------------------------------------------
  late FocusNode _passwordFocusNode;

  //stores:---------------------------------------------------------------------
  final _store = FormStore();

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _themeStore = Provider.of<ThemeStore>(context);
    _userStore = Provider.of<UserStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: EmptyAppBar(),
      body: _buildBody(),
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Material(
      child: Stack(
        children: <Widget>[
          MediaQuery.of(context).orientation == Orientation.landscape
              ? Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: _buildLeftSide(),
                    ),
                    Expanded(
                      flex: 1,
                      child: _buildRightSide(),
                    ),
                  ],
                )
              : Center(child: _buildRightSide()),
          Observer(
            builder: (context) {
              return _store.success
                  ? navigate(context)
                  : _showErrorMessage(_store.errorStore.errorMessage);
            },
          ),
          Observer(
            builder: (context) {
              return _userStore.success
                  ? navigate(context)
                  : _showErrorMessage(_userStore.errorStore.errorMessage);
            },
          ),
          Observer(
            builder: (context) {
              return Visibility(
                visible: _store.loading,
                child: CustomProgressIndicatorWidget(),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildLeftSide() {
    return SizedBox.expand(
      child: Image.asset(
        Assets.carBackground,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildRightSide() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildHeaderLogo(),
            SizedBox(height: 24.0),
            _buildUserIdField(),
            SizedBox(
              height: 8,
            ),
            _buildPasswordField(),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                'Or Continue With',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
            _buildSignInOtherMethod(),
            _buildForgotPasswordButton(),
            _buildSignInButton()
          ],
        ),
      ),
    );
  }

  Widget _buildSignInOtherMethod() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          // width: DeviceUtils.getScaledWidth(context, 0.3),
          height: 70,
          child: ElevatedButton(
            onPressed: () {
              // TODO: Handle sign in with Facebook logic
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.containerDark,
              foregroundColor: AppColors.containerDark,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                // side: BorderSide(color: AppColors.backgroundLight, width: 1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/icons/ic_facebook.png',
                  height: 30,
                  ),
                SizedBox(width: 8),
                Text(
                  'Facebook',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          // width: DeviceUtils.getScaledWidth(context, 0.3),
          height: 70,
          child: ElevatedButton(
            onPressed: () async {
              // TODO: Handle sign in with Google logic
              _userStore.signInWithGoogle();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.containerDark,
              foregroundColor: AppColors.containerDark,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                // side: BorderSide(color: AppColors.backgroundLight, width: 1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/icons/ic_google.png',
                  height: 30,
                  ),
                SizedBox(width: 8),
                Text(
                  'Google',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderLogo() {
    return Column(
      children: <Widget>[
        Image.asset(
          Assets.appLogo,
          height: 150,
        ),
        ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              colors: [
                AppColors.primaryGradientDarkTopLeft,
                AppColors.primaryGradientDarkBottomRight
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ).createShader(bounds);
          },
          child: Text(
            "SafeWalk",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.white, // The color of the text within the gradient
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 64, right: 64, top: 16, bottom: 16),
          child: Text(
            "Your Safety Companion",
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildUserIdField() {
    return Observer(
      builder: (context) {
        return TextField(
          decoration: InputDecoration(
            hintText:
                AppLocalizations.of(context).translate('login_et_user_email'),
            prefixIcon: Icon(Icons.person,
                color: _themeStore.darkMode ? Colors.white70 : Colors.black54),
            filled: true,
            fillColor: AppColors.containerDark,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            errorText: _store.formErrorStore.userEmail,
          ),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          controller: _userEmailController,
          autofocus: false,
          onChanged: (value) {
            _store.setUserId(_userEmailController.text);
          },
          onSubmitted: (value) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
        );
      },
    );
  }

  Widget _buildPasswordField() {
    return Observer(
      builder: (context) {
        return TextField(
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)
                .translate('login_et_user_password'),
            prefixIcon: Icon(Icons.lock,
                color: _themeStore.darkMode ? Colors.white70 : Colors.black54),
            filled: true,
            fillColor: AppColors.containerDark,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            errorText: _store.formErrorStore.password,
          ),
          obscureText: true,
          controller: _passwordController,
          focusNode: _passwordFocusNode,
          onChanged: (value) {
            _store.setPassword(_passwordController.text);
          },
        );
      },
    );
  }

  Widget _buildForgotPasswordButton() {
    return Align(
      alignment: FractionalOffset.center,
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(0.0),
          minimumSize: Size(0, 0),
        ),
        child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        colors: [Colors.deepOrange, Colors.greenAccent], 
                        begin: Alignment.centerLeft, 
                        end: Alignment.centerRight, 
                      ).createShader(bounds);
                    },
                    child: Text(
                      "Forgot Your Password?",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // The color of the text within the gradient
                      ),
                    ),
                  )
      ),
    );
  }

  Widget _buildSignInButton() {
    return InkWell(
      onTap: () async {
        if (_store.canLogin) {
          DeviceUtils.hideKeyboard(context);
          _store.login();
        } else {
          _showErrorMessage('Please fill in all fields');
        }
      },
      child: Container(
        height: 58,
        padding: EdgeInsets.only(
          left: 56.0,
          right: 56.0,
          top: 16,
          bottom: 16,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            gradient: LinearGradient(
              colors: [
                AppColors.primaryGradientDarkTopLeft,
                AppColors.primaryGradientDarkBottomRight
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget navigate(BuildContext context) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(Preferences.is_logged_in, true);
    });

    Future.delayed(Duration(milliseconds: 0), () {
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.home, (Route<dynamic> route) => false);
    });

    return Container();
  }

  // General Methods:-----------------------------------------------------------
  _showErrorMessage(String message) {
    if (message.isNotEmpty) {
      Future.delayed(Duration(milliseconds: 0), () {
        if (message.isNotEmpty) {
          FlushbarHelper.createError(
            message: message,
            title: AppLocalizations.of(context).translate('home_tv_error'),
            duration: Duration(seconds: 3),
          )..show(context);
        }
      });
    }

    return SizedBox.shrink();
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _userEmailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
}
