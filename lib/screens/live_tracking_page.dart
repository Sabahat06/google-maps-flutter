import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_tutorial/static_var.dart';
import 'package:location/location.dart';

class LiveTrackingScreen extends StatefulWidget {

  @override
  _LiveTrackingScreenState createState() => _LiveTrackingScreenState();
}

class _LiveTrackingScreenState extends State<LiveTrackingScreen> {
  var kGoogleApiKey = 'AIzaSyColRELIlq7P8tMLqsShIZRAaGfI2OCNI8';

  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng sourceLocation = LatLng(33.6314449, 72.9228646);
  static const LatLng destinationLocation = LatLng(33.6348019, 72.9295481);

  List<LatLng> polyLineCoordinates = [];
  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  getPolyPoint() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyColRELIlq7P8tMLqsShIZRAaGfI2OCNI8",
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polyLineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    setState(() {});
  }

  setCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, "assets/car.png").then((icon) => currentLocationIcon = icon);
    print(currentLocationIcon);
  }
  LocationData currentLocation;
  

  Future<LocationData> loadCurrentLocation() async {
    Location location = Location();

    PermissionStatus permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus == PermissionStatus.denied) {
        return null;
      }
    }
    currentLocation = await location.getLocation();
    print(currentLocation);
    setState(() {});
    GoogleMapController googleMapController = await _controller.future;
    location.onLocationChanged.listen((event) async {
      currentLocation = await location.getLocation();
      googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(currentLocation.latitude, currentLocation.longitude), zoom: 14.5)));
      setState(() {});
    });

  }

  @override
  void initState() {
    loadCurrentLocation();
    getPolyPoint();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // _createMarkerImageFromAsset(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Track Order')),
      body: currentLocation == null
        ? const Center(child: CircularProgressIndicator(),)
        : GoogleMap(
          initialCameraPosition: CameraPosition(target: LatLng(currentLocation.latitude, currentLocation.longitude), zoom: 14.5),
          polylines: {
            Polyline(
              polylineId: const PolylineId("result"),
              points: polyLineCoordinates,
              color: Colors.blue.shade300,
              width: 5
            )
          },
          markers: {
            Marker(
              markerId: const MarkerId("current location"),
              position: LatLng(currentLocation.latitude, currentLocation.longitude),
              // icon: currentLocationIcon
            ),
            const Marker(
              markerId: MarkerId("Source"),
              position: sourceLocation
            ),
            const Marker(
              markerId: MarkerId("Destination"),
              position: destinationLocation
            ),
          },
          onMapCreated: (mapController) {
            _controller.complete(mapController);
          },
        ),
    );
  }
}
