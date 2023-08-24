import 'package:flutter/material.dart';
import 'package:safewalk/constants/colors.dart';
import 'package:safewalk/utils/device/device_utils.dart';

class AddEmergencyScreen extends StatefulWidget {
  const AddEmergencyScreen({super.key});

  @override
  State<AddEmergencyScreen> createState() => _AddEmergencyScreenState();
}

class _AddEmergencyScreenState extends State<AddEmergencyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Add Emergency Contact",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildPhotoHolder(),
            _buildNameField(),
            _buildPhoneField(),
            _buildEmailField(),
            SizedBox(
              height: DeviceUtils.getScaledHeight(context, 0.2)
            ),
            _buildButtonField()
          ],
        ),
      ),
    );
  }

  Widget _buildButtonField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 50,
          width: DeviceUtils.getScaledWidth(context, 0.2),
          margin: EdgeInsets.only(left:16 , top: 8),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.withOpacity(0.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        GestureDetector(
          child: Container(
            height: 50,
            width: DeviceUtils.getScaledWidth(context, 0.65),
            margin: EdgeInsets.only(right: 16, top: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryGradientDarkTopLeft,
                  AppColors.primaryGradientDarkBottomRight,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                "Save",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            )
          ),
          onTap: () {
            print("Save");
          },
        ),
      ],
    );
  }

  Widget _buildNameField() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        decoration: InputDecoration(
          labelText: "Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneField() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        decoration: InputDecoration(
          labelText: "Phone",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        decoration: InputDecoration(
          labelText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoHolder() {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        height: 210,
        width: 210,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primaryGradientDarkTopLeft,
              AppColors.primaryGradientDarkBottomRight,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        child: GestureDetector(
          child: Container(
            height: 200,
            width: 200,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.backgroundDark,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
                child: Image.asset(
              'assets/icons/ic_image.png',
              height: 100,
              width: 100,
            )),
          ),
          onTap: () {
            print("Add photo");
          },
        ),
      ),
    );
  }
}
