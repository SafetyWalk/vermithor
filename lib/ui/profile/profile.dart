import 'package:safewalk/constants/colors.dart';
import 'package:safewalk/stores/user/user_store.dart';
import 'package:safewalk/utils/device/device_utils.dart';
import 'package:safewalk/stores/language/language_store.dart';
import 'package:safewalk/stores/theme/theme_store.dart';
import 'package:safewalk/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:material_dialog/material_dialog.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //stores:---------------------------------------------------------------------
  late ThemeStore _themeStore;
  late LanguageStore _languageStore;
  late UserStore _userStore;

  bool _alwaysOnLocation = false;
  bool _zzz = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // initializing stores
    _languageStore = Provider.of<LanguageStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
    _userStore = Provider.of<UserStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Center(
                child: Image.network(
                  _userStore.firebaseUser!.currentUser?.photoURL ??
                      "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png",
                  scale: 0.225,
                ),
              ),
              SizedBox(height: DeviceUtils.getScaledHeight(context, 0.2)),
              Column(
                children: [
                  SizedBox(height: DeviceUtils.getScaledHeight(context, 0.35)),
                  Container(
                    height: DeviceUtils.getScaledHeight(context, 0.65),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.backgroundDark,
                          AppColors.backgroundDark,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: _buildMainContent(),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 5,
              width: 75,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "${_userStore.firebaseUser!.currentUser?.displayName ?? "Guest User"}",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Montserrat",
                ),
                textAlign: TextAlign.start,
              ),
              IconButton(
                onPressed: () {
                  // TODO: Edit profile
                },
                icon: Icon(
                  Icons.edit,
                  color: AppColors.primaryDark,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "${_userStore.firebaseUser!.currentUser?.phoneNumber ?? "phone number empty"}",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Montserrat",
                  color: Colors.grey.withOpacity(0.5),
                ),
                textAlign: TextAlign.start,
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "${_userStore.firebaseUser!.currentUser?.email ?? "Guest User"}",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Montserrat",
                  color: Colors.grey.withOpacity(0.5),
                ),
                textAlign: TextAlign.start,
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            children: [
              Text(
                "Settings and Privacy",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Montserrat",
                ),
                textAlign: TextAlign.start,
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Icon(Icons.location_pin, color: AppColors.primaryDark),
                ),
                Text(
                  "Always-on location tracking",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat",
                  ),
                  textAlign: TextAlign.start,
                ),
                Spacer(
                  flex: 1,
                ),
                Switch(
                  value: _alwaysOnLocation,
                  onChanged: (value) {
                    setState(() {
                      _alwaysOnLocation = value;
                    });
                  },
                  activeTrackColor: AppColors.primaryDark,
                  activeColor: AppColors.primaryDark,
                  
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Icon(Icons.location_pin, color: AppColors.primaryDark),
                ),
                Text(
                  "zzz",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Montserrat",
                  ),
                  textAlign: TextAlign.start,
                ),
                Spacer(
                  flex: 1,
                ),
                Switch(
                  value: _zzz,
                  onChanged: (value) {
                    setState(() {
                      _zzz = value;
                    });
                  },
                  activeTrackColor: AppColors.primaryDark,
                  activeColor: AppColors.primaryDark,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // General Methods:-----------------------------------------------------------
  _buildLanguageDialog() {
    _showDialog<String>(
      context: context,
      child: MaterialDialog(
        borderRadius: 5.0,
        enableFullWidth: true,
        title: Text(
          AppLocalizations.of(context).translate('home_tv_choose_language'),
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        headerColor: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        closeButtonColor: Colors.white,
        enableCloseButton: true,
        enableBackButton: false,
        onCloseButtonClicked: () {
          Navigator.of(context).pop();
        },
        children: _languageStore.supportedLanguages
            .map(
              (object) => ListTile(
                dense: true,
                contentPadding: EdgeInsets.all(0.0),
                title: Text(
                  object.language!,
                  style: TextStyle(
                    color: _languageStore.locale == object.locale
                        ? Theme.of(context).primaryColor
                        : _themeStore.darkMode
                            ? Colors.white
                            : Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  // change user language based on selected locale
                  _languageStore.changeLanguage(object.locale!);
                },
              ),
            )
            .toList(),
      ),
    );
  }

  _showDialog<T>({required BuildContext context, required Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T? value) {
      // The value passed to Navigator.pop() or null.
    });
  }
}
