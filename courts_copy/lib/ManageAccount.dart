import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'orderedFurniture.dart';
import 'main.dart';
import 'customer.dart';
import 'updateprofile.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

void main() => runApp(const ManageAccount());

class Customer{
  final String customerid;
  final String username;
  final String password;
  final String address;
  final String email;
  final String phonenumber;


  Customer({required this.customerid, required this.username, required this.password, required this.address, required this.email, required this.phonenumber});

  factory Customer.fromJson(Map<String, dynamic> json){
    return Customer(
      customerid: json['CustomerID'],
      username: json['Username'],
      password: json['Password'],
      address: json['Address'],
      email: json['Email'],
      phonenumber: json['PhoneNumber'],
    );
  }
}

class ManageAccount extends StatelessWidget {
  const ManageAccount({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'COURTS',
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}): super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  late Future<List<Customer>> futureData;

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('COURTS'),
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
                  MaterialPageRoute(builder: (context) => const ViewOrderedFurniture()),
                );
              },
            ),
            ListTile(
              title: const Text('Find Nearest Store'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
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
                logout();
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Form(
        child:SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text('Manage Account',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),

              Padding(
                padding: EdgeInsets.all(5.0),
              ),

              Text('Username: Grace', textAlign: TextAlign.center,),
              Text('Password: grace', textAlign: TextAlign.center,),
              Text('Address: 29 Jalan SS 22/3, Damansara Jaya, 47400 Petaling Jaya',
              textAlign: TextAlign.center,),
              Text('E-mail: gracefongcl@gmail.com', textAlign: TextAlign.center,),
              Text('Phone Number: 0132091628', textAlign: TextAlign.center,),

              Padding(
                padding: EdgeInsets.all(28.0),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const UpdateProfile()),
                          );
                      },
                      child: const Text('Update Profile'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}