import 'package:another_flushbar/flushbar_helper.dart';
import 'package:safewalk/constants/colors.dart';
import 'package:safewalk/data/sharedpref/constants/preferences.dart';
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

class SelfPictScreen extends StatefulWidget {
  @override
  _SelfPictScreenState createState() => _SelfPictScreenState();
}

class _SelfPictScreenState extends State<SelfPictScreen> {
  //text controllers:-----------------------------------------------------------
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  //stores:---------------------------------------------------------------------
  late ThemeStore _themeStore;

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
          _buildContent(),
          Observer(
            builder: (context) {
              return _store.success
                  ? navigate(context)
                  : _showErrorMessage(_store.errorStore.errorMessage);
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

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildHeader(),
            SizedBox(height: 24.0),
            _buildGalleryUpload(),
            SizedBox(height: 24.0),
            _buildCameraUpload(),
            SizedBox(
              height: DeviceUtils.getScaledHeight(context, 0.2),
            ),
            _buildNextButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildGalleryUpload() {
    return Container(
      width: DeviceUtils.getScaledWidth(context, 0.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: AppColors.containerDark,
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            child: Image.asset(
              "assets/icons/ic_gallery.png",
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCameraUpload() {
    return Container(
      width: DeviceUtils.getScaledWidth(context, 0.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: AppColors.containerDark,
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            child: Image.asset(
              "assets/icons/ic_camera.png",
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextButton() {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(Routes.success);
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
          "Next",
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

  Widget _buildHeader() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 32,
        ),
        Text(
          "Upload Your Photo Profile",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
            color: Colors.white, // The color of the text within the gradient
          ),
        ),
        SizedBox(height: 16),
        Text(
          "This data will be displayed in your account profile for security",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.normal,
            color: Colors.white, // The color of the text within the gradient
          ),
        ),
      ],
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
    _firstNameController.dispose();
    _lastNameController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
}
