import 'package:safewalk/data/sharedpref/constants/preferences.dart';
import 'package:safewalk/stores/user/user_store.dart';
import 'package:safewalk/utils/device/device_utils.dart';
import 'package:safewalk/utils/routes/routes.dart';
import 'package:safewalk/stores/language/language_store.dart';
import 'package:safewalk/stores/theme/theme_store.dart';
import 'package:safewalk/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:material_dialog/material_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigatorScreen extends StatefulWidget {
  @override
  _NavigatorScreenState createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  //stores:---------------------------------------------------------------------
  late ThemeStore _themeStore;
  late LanguageStore _languageStore;
  late UserStore _userStore;

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
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  // app bar methods:-----------------------------------------------------------
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text('Navigator'),
      actions: _buildActions(context),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    return <Widget>[
      _buildLanguageButton(),
      _buildThemeButton(),
      _buildLogoutButton(),
    ];
  }

  Widget _buildThemeButton() {
    return Observer(
      builder: (context) {
        return IconButton(
          onPressed: () {
            _themeStore.changeBrightnessToDark(!_themeStore.darkMode);
          },
          icon: Icon(
            _themeStore.darkMode ? Icons.brightness_5 : Icons.brightness_3,
          ),
        );
      },
    );
  }

  Widget _buildLogoutButton() {
    return IconButton(
      onPressed: () {
        SharedPreferences.getInstance().then((preference) {
          preference.setBool(Preferences.is_logged_in, false);
          Navigator.of(context).pushReplacementNamed(Routes.login);
        });
      },
      icon: Icon(
        Icons.power_settings_new,
      ),
    );
  }

  Widget _buildLanguageButton() {
    return IconButton(
      onPressed: () {
        _buildLanguageDialog();
      },
      icon: Icon(
        Icons.language,
      ),
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: DeviceUtils.getScaledHeight(context, 0.1)
          ),
          _buildMainContent(),
        ],
      ),
    );
  }


  Widget _buildMainContent() {
    return Container(
      // create a button to redirect to maps
      child: Center(
        child: Column(
          children: [
            // SizedBox(
            //   height: DeviceUtils.getScaledHeight(context, 0.3),
            // ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.library);
              },
              child: Text('Go to Library'),
            ),  
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.storage);
              },
              child: Text('Go to Storage'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.map);
              },
              child: Text(
                "Go to Maps"
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.distanceMap);
              },
              child: Text(
                "Go to Distance Maps"
              ),
            ),
          ],
        ),
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



// import 'package:flutter/material.dart';
// import 'package:safewalk/utils/device/device_utils.dart';
// import 'package:safewalk/utils/routes/routes.dart';

// class NavigatorScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Navigator'),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             SizedBox(
//               height: DeviceUtils.getScaledHeight(context, 0.3),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pushNamed(Routes.library);
//               },
//               child: Text('Go to Library'),
//             ),  
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pushNamed(Routes.storage);
//               },
//               child: Text('Go to Storage'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pushNamed(Routes.map);
//               },
//               child: Text(
//                 "Go to Maps"
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pushNamed(Routes.distanceMap);
//               },
//               child: Text(
//                 "Go to Distance Maps"
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }