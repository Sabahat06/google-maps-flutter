import 'package:flutter/material.dart';
import 'package:google_maps_flutter_tutorial/screens/current_location_screen.dart';
import 'package:google_maps_flutter_tutorial/screens/product_screen.dart';
import 'package:google_maps_flutter_tutorial/screens/search_places_screen.dart';
import 'package:google_maps_flutter_tutorial/screens/simple_map_screen.dart';
import 'package:google_maps_flutter_tutorial/static_var.dart';
import 'package:location/location.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    loadCurrentLocation();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Google Maps"),
        centerTitle: true,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  if(StaticVariable.currentLocation.latitude!=null) {
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){return const SimpleMapScreen();}));
                  }
                },
                child: Container(
                  color: Colors.green,
                  width: double.infinity,
                  height: 45,
                  child: const Center(child:  Text("Simple Map", style: TextStyle(fontSize: 16, color: Colors.white),)),
                ),
              ),
              const SizedBox(height: 10,),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){return const CurrentLocationScreen();}));
                },
                child: Container(
                  color: Colors.orange,
                  width: double.infinity,
                  height: 45,
                  child: const Center(child: Text("User current location", style: TextStyle(fontSize: 16, color: Colors.white),)),
                ),
              ),
              const SizedBox(height: 10,),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){return const SearchPlacesScreen();}));
                },
                child: Container(
                  color: Colors.indigo,
                  width: double.infinity,
                  height: 45,
                  child: const Center(child: Text("Search Places", style: TextStyle(fontSize: 16, color: Colors.white),)),
                ),
              ),
              const SizedBox(height: 10,),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){return ProductScreenTab();}));
                },
                child: Container(
                  color: Colors.indigo,
                  width: double.infinity,
                  height: 45,
                  child: const Center(child: Text("Get Product", style: TextStyle(fontSize: 16, color: Colors.white),)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<LocationData> loadCurrentLocation() async {
    Location location = Location();
    PermissionStatus permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus == PermissionStatus.denied) {
        return null;
      }
    }
    StaticVariable.currentLocation = await location.getLocation();
    location.onLocationChanged.listen((event) async {
      StaticVariable.currentLocation = await location.getLocation();
    });
  }
}
