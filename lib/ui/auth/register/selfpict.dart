import 'dart:io';

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
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

  //stores:---------------------------------------------------------------------
  late ThemeStore _themeStore;
  late FormStore _formStore;

  //focus node:-----------------------------------------------------------------
  late FocusNode _passwordFocusNode;

  // firebase storage:----------------------------------------------------------
  final Reference _storage = FirebaseStorage.instance.ref();
  final _imagePicker = ImagePicker();

  File? _image;
  bool _isUploading = false;
  bool _isDone = false;
  String _downloadURL = '';

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
          _buildContent(),
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
            if (_image != null) Image.file(_image!),
            if (_isUploading) LinearProgressIndicator(),
            if (_image != null) SizedBox(height: 24.0),
            if (_image != null && !_isDone)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final _imageName = _image!.path.split('/').last;
                      setState(() {
                        _isUploading = true;
                      });

                      // create a new reference in your Firebase Cloud Storage
                      final newImageRef =
                          _storage.child('images/profile/$_imageName');

                      try {
                        // put a file at this references location
                        await newImageRef.putFile(_image!);

                        // Get the download URL
                        final downloadURL = await newImageRef.getDownloadURL();

                        setState(() {
                          _isUploading = false;
                          _downloadURL = downloadURL;
                          _isDone = true;
                          _formStore.setPhotoUrl(_downloadURL);
                        });

                        // TODO: Delete this shit
                        print("testsetest");
                        print(_downloadURL);
                      } on FirebaseException catch (error) {
                        setState(() {
                          _isUploading = false;
                        });
                        // ignore: avoid_print
                        print(error);
                      }
                    },
                    child: const Text('Confirm Image'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        _image = null;
                      });
                    },
                    child: const Text('Remove Image'),
                  ),
                ],
              ),
            if (_image == null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildGalleryUpload(),
                  SizedBox(height: 24.0),
                  _buildCameraUpload(),
                ],
              ),
            SizedBox(
              height: DeviceUtils.getScaledHeight(context, 0.23),
            ),
            if (_isDone)
              _buildNextButton()
          ],
        ),
      ),
    );
  }

  Widget _buildGalleryUpload() {
    return GestureDetector(
      child: Container(
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
      ),
      onTap: _image == null
          ? () async {
              final XFile? image =
                  await _imagePicker.pickImage(source: ImageSource.gallery);

              setState(() {
                _image = File(image!.path);
              });
            }
          : null,
    );
  }

  Widget _buildCameraUpload() {
    return GestureDetector(
      child: Container(
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
      ),
      onTap: () {
        print("belom implement hehe :D");
        // TODO: implement camera upload
      },
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
