import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'ManageAccount.dart';
import 'package:flutter/material.dart';
import 'orderedFurniture.dart';
import 'customer.dart';
import 'main.dart';
import 'locations.dart' as locations;
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


void main(){
  runApp(const NearestStore());
}

class NearestStore extends StatelessWidget {
  const NearestStore({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'COURTS',
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {

  const MyApp({Key? key}) : super(key : key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      for (final shop in googleOffices.Shops) {
        final marker = Marker(
          markerId: MarkerId(shop.name),
          position: LatLng(shop.lat, shop.lng),
          infoWindow: InfoWindow(
            title: shop.name,
            snippet: shop.address,
          ),
        );
        _markers[shop.name] = marker;
      }
    });
  }


  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
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
    title: const Text('COURTS Malaysia Stores'),
    elevation: 2,
    ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              child: Text('COURTS'),
            ),

            ListTile(
              title: const Text('Home'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CustomerPage()),
                );
              },
            ),

      ListTile(
        title: const Text('Purchase Furniture'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CustomerPage()),
          );
        },
      ),
        ListTile(
          title: const Text('Make Payment'),
          onTap: () {
            // Update the state of the app
            // ...
            // Then close the drawer
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Select a product first')));
          },
        ),
            ListTile(
              title: const Text('View Ordered Furniture'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewOrderedFurniture()),
                );
              },
            ),
            ListTile(
              title: const Text('Find Nearest Store'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer

              },
            ),
            ListTile(
              title: const Text('Manage Account'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ManageAccount()),
                );
              },
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                logout();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage()),
                );
              },
            ),
          ],
        ),
      ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
          target: LatLng(4.2105, 101.9758),
          zoom: 10.0,
        ),
          markers: _markers.values.toSet(),
      ),
    ),
    );
  }
}