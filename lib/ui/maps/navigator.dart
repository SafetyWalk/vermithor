import 'package:flutter/material.dart';
import 'package:safewalk/utils/device/device_utils.dart';
import 'package:safewalk/utils/routes/routes.dart';

class NavigatorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Navigator'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: DeviceUtils.getScaledHeight(context, 0.3),
            ),
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
}