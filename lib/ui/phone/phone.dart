import 'package:flutter/material.dart';
import 'package:safewalk/constants/colors.dart';
import 'package:safewalk/utils/routes/routes.dart';

class PhoneScreen extends StatefulWidget {
  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Menu'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Hotline",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildCallHopeHelps(),
            _buildCallPolice(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Emergency contact",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildAddEmergency()
          ],
        ),
      ),
    );
  }

  Widget _buildAddEmergency() {
    return GestureDetector (
      child: Container(
        height: 70,
        margin: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            "+ Add Emergency Contact",
            style: TextStyle(
              fontSize: 16,
              color: AppColors.primaryTextColorDark.withOpacity(0.5)
            ),
          ),
        ),
      ),
      onTap: () {
        // print("add emergency");
        Navigator.of(context).pushNamed(Routes.addEmergency);
      },
    );
  }

  Widget _buildCallHopeHelps() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      height: 100,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            height: 70,
            width: 70,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                "assets/icons/ic_hopehelps.jpeg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "HopeHelps",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "082299788860",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 16, right: 8),
            height: 100,
            width: 90,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryGradientDarkTopLeft,
                  AppColors.primaryGradientDarkBottomRight,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
              onPressed: () {
                // DeviceUtils.launchURL("tel:082299788860");
                print("telpon biasa");
              },
              icon: Icon(
                Icons.call,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
          Container(
            height: 100,
            width: 50,
            child: IconButton(
              onPressed: () {
                // DeviceUtils.launchURL("sms:082299788860");
                print("wassap");
              },
              icon: Image.asset(
                "assets/icons/ic_whatsapp.png",
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCallPolice() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      height: 100,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            height: 70,
            width: 70,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                "assets/icons/ic_police.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Police",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "911",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 70, right: 8),
            height: 100,
            width: 90,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryGradientDarkTopLeft,
                  AppColors.primaryGradientDarkBottomRight,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
              onPressed: () {
                // DeviceUtils.launchURL("tel:082299788860");
                print("telpon biasa");
              },
              icon: Icon(
                Icons.call,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
          Container(
            height: 100,
            width: 50,
            child: IconButton(
              onPressed: () {
                // DeviceUtils.launchURL("sms:082299788860");
                print("wassap");
              },
              icon: Image.asset(
                "assets/icons/ic_whatsapp.png",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
