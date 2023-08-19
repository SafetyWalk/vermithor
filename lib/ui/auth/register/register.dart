import 'package:another_flushbar/flushbar_helper.dart';
import 'package:safewalk/constants/assets.dart';
import 'package:safewalk/constants/colors.dart';
import 'package:safewalk/data/sharedpref/constants/preferences.dart';
import 'package:safewalk/utils/device/device_utils.dart';
import 'package:safewalk/utils/routes/routes.dart';
import 'package:safewalk/stores/form/form_store.dart';
import 'package:safewalk/stores/theme/theme_store.dart';
import 'package:safewalk/utils/locale/app_localization.dart';
import 'package:safewalk/widgets/empty_app_bar_widget.dart';
import 'package:safewalk/widgets/progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //text controllers:-----------------------------------------------------------
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  //stores:---------------------------------------------------------------------
  late ThemeStore _themeStore;
  late FormStore _formStore;

  //focus node:-----------------------------------------------------------------
  late FocusNode _passwordFocusNode;

  bool _isKeepLoggedIn = false;
  bool _isSubscribe = false;
  bool _isObscure = true;

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _themeStore = Provider.of<ThemeStore>(context);
    _formStore = Provider.of<FormStore>(context);
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
              return _formStore.success
                  ? navigate(context)
                  : _showErrorMessage(_formStore.errorStore.errorMessage);
            },
          ),
          Observer(
            builder: (context) {
              return Visibility(
                visible: _formStore.loading,
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
            _buildUsernameField(),
            SizedBox(
              height: 8,
            ),
            _buildEmailField(),
            SizedBox(
              height: 8,
            ),
            _buildPasswordField(),
            SizedBox(
              height: 16,
            ),
            _buildCheckbox(),
            _buildSignInButton()
          ],
        ),
      ),
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
        Text(
          'Sign Up For Free',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildUsernameField() {
    return Observer(
      builder: (context) {
        return TextField(
          decoration: InputDecoration(
            hintText: 'Enter yor username',
            prefixIcon: Icon(Icons.person,
                color: _themeStore.darkMode ? Colors.white70 : Colors.black54),
            filled: true,
            fillColor: AppColors.containerDark,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            errorText: _formStore.formErrorStore.username,
          ),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          controller: _usernameController,
          autofocus: false,
          onChanged: (value) {
            _formStore.setUsername(_usernameController.text);
          },
          onSubmitted: (value) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
        );
      },
    );
  }

  Widget _buildEmailField() {
    return Observer(
      builder: (context) {
        return TextField(
          decoration: InputDecoration(
            hintText: 'Enter your email',
            prefixIcon: Icon(Icons.email,
                color: _themeStore.darkMode ? Colors.white70 : Colors.black54),
            filled: true,
            fillColor: AppColors.containerDark,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            errorText: _formStore.formErrorStore.userEmail,
          ),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          controller: _userEmailController,
          autofocus: false,
          onChanged: (value) {
            _formStore.setUserEmail(_userEmailController.text);
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
            errorText: _formStore.formErrorStore.password,
            suffixIcon: IconButton(
              icon: Icon(
                // Show password
                _isObscure ? Icons.visibility : Icons.visibility_off,
                color: _themeStore.darkMode ? Colors.white70 : Colors.black54,
              ),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              },
            ),
          ),
          obscureText: _isObscure,
          controller: _passwordController,
          focusNode: _passwordFocusNode,
          onChanged: (value) {
            _formStore.setPassword(_passwordController.text);
          },
        );
      },
    );
  }

  Widget _buildCheckbox() {
    return Column(
      children: <Widget>[
        Row(
          children: [
            Observer(
              builder: (context) {
                return Checkbox(
                  checkColor: Colors.white,
                  activeColor: AppColors.primaryDark,
                  fillColor: MaterialStateProperty.all<Color>(
                      AppColors.primaryGradientDarkBottomRight),
                  value: _isKeepLoggedIn,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: CircleBorder(),
                  onChanged: (value) {
                    setState(() {
                      _isKeepLoggedIn = value!;
                    });
                  },
                );
              },
            ),
            Text(
              'Keep me logged in',
              style: TextStyle(
                color: _themeStore.darkMode ? Colors.white70 : Colors.black54,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Observer(
              builder: (context) {
                return Checkbox(
                  checkColor: Colors.white,
                  activeColor: AppColors.primaryDark,
                  fillColor: MaterialStateProperty.all<Color>(
                      AppColors.primaryGradientDarkBottomRight),
                  value: _isSubscribe,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: CircleBorder(),
                  onChanged: (value) {
                    setState(() {
                      _isSubscribe = value!;
                    });
                  },
                );
              },
            ),
            Text(
              'Email me about special pricing',
              style: TextStyle(
                color: _themeStore.darkMode ? Colors.white70 : Colors.black54,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSignInButton() {
    return InkWell(
      onTap: () async {
        if (_formStore.username.isNotEmpty &&
            _formStore.userEmail.isNotEmpty &&
            _formStore.password.isNotEmpty) {
          DeviceUtils.hideKeyboard(context);
          Navigator.of(context).pushNamed(Routes.biodata);
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
          "Create Account",
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
