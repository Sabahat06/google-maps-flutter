import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_tutorial/static_var.dart';

class SimpleMapScreen extends StatefulWidget {
  const SimpleMapScreen({Key key}) : super(key: key);

  @override
  _SimpleMapScreenState createState() => _SimpleMapScreenState();
}

class _SimpleMapScreenState extends State<SimpleMapScreen> {
  Set<Marker> markers = {};
  @override
  void initState() {
    _requestTimer();
    super.initState();
  }

  Future<void> _requestTimer() async {
    await currentLocationOnMap();
    await Future.delayed(
      const Duration(seconds: 1),
    );
    _requestTimer();
  }

  final Completer<GoogleMapController> _controller = Completer();
  CameraPosition initialPosition = CameraPosition(target: LatLng(StaticVariable.currentLocation.latitude, StaticVariable.currentLocation.longitude), zoom: 20.0);

  @override
  Widget build(BuildContext context) {
    markers.add(Marker(markerId: const MarkerId('currentLocation'),position: LatLng(StaticVariable.currentLocation.latitude, StaticVariable.currentLocation.longitude)));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Simple Google Map"),
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition: initialPosition,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: markers

      ),
    );
  }


  Future<void> currentLocationOnMap() async {
    initialPosition = CameraPosition(target: LatLng(StaticVariable.currentLocation.latitude, StaticVariable.currentLocation.longitude), zoom: 16.0);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(initialPosition));
    markers.clear();
    markers.add(Marker(markerId: const MarkerId('currentLocation'),position: LatLng(StaticVariable.currentLocation.latitude, StaticVariable.currentLocation.longitude)));
  }
}
