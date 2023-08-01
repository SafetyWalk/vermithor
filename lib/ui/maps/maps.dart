import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:safewalk/stores/location/locations.dart' as locations;

class MapsScreen extends StatefulWidget {
  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  final Map<String, Marker> _markers = {};
  late GoogleMapController _mapController;
  double _zoomLevel = 15.4;
  bool _nightMode = false;
  bool _isMapCreated = false;

  void _zoomIn() {
    setState(() {
      _zoomLevel = min(_zoomLevel + 1, 20); // Set a maximum zoom level if desired
    });
    _updateCameraPosition();
  }

  void _zoomOut() {
    setState(() {
      _zoomLevel = max(_zoomLevel - 1, 1); // Set a minimum zoom level if desired
    });
    _updateCameraPosition();
  }

  void _updateCameraPosition() {
    _mapController?.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(-6.36046, 106.82722), zoom: _zoomLevel),
    ));
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _mapController = controller;
      _isMapCreated = true;
      _markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        _markers[office.name] = marker;
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green[700],
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('University of Indonesia'),
          elevation: 2,
        ),
        body: Stack(
          children: [
            GoogleMap(
              onMapCreated: (controller) {
                _mapController = controller;
                _onMapCreated(controller);
              },
              initialCameraPosition: const CameraPosition(
                target: LatLng(-6.36046, 106.82722),
                zoom: 15.4,
              ),
              markers: _markers.values.toSet(),
              myLocationButtonEnabled: false
            ),
            Positioned(
              bottom: 16,
              right: 16,
              child: Column(
                children: [
                  FloatingActionButton(
                    onPressed: _zoomIn,
                    child: Icon(Icons.zoom_in),
                  ),
                  SizedBox(height: 10),
                  FloatingActionButton(
                    onPressed: _zoomOut,
                    child: Icon(Icons.zoom_out),
                  ),
                  _nightModeToggler()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _getFileData(String path) async {
    return rootBundle.loadString(path);
  }

  void _setMapStyle(String mapStyle) {
    setState(() {
      _nightMode = true;
      _mapController.setMapStyle(mapStyle);
    });
  }

  // Should only be called if _isMapCreated is true.
  Widget _nightModeToggler() {
    // assert(_isMapCreated);
    return TextButton(
      child: Text('${_nightMode ? 'disable' : 'enable'} night mode'),
      onPressed: () {
        if (_nightMode) {
          setState(() {
            _nightMode = false;
            _mapController.setMapStyle(null);
          });
        } else {
          _getFileData('assets/maps/night_mode.json').then(_setMapStyle);
        }
      },
    );
  }
}