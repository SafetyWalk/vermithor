import 'package:flutter/material.dart';
import 'package:safewalk/utils/device/device_utils.dart';

class PhoneScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Menu'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: DeviceUtils.getScaledHeight(context, 0.3),
            ),
            Text.rich(
              TextSpan(
                text: 'Under Construction :D',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}