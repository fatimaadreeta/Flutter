import 'package:flutter/material.dart';
import 'main.dart';
import 'customer.dart';
import 'ManageAccount.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'orderedFurniture.dart';
import 'purchaseProduct.dart';
import 'dart:convert';
import 'dart:ffi';

void main() => runApp(const UpdateProfile());

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

updateCustomer(String username, String password, String address, String email, String phonenumber) async {
  final response = await http.post(
      Uri.parse('http://192.168.1.108/bit311/updateprofile.php'),
      body: {
        'username': username,
        'password': password,
        'address': address,
        'email': email,
        'phonenumber': phonenumber,
      }
  );
}

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({Key? key}): super(key: key);

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
  Future<Customer>? _futureCustomer;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  late FocusNode myFocusNode;
  late bool _active;

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  @override
  void initState(){
    super.initState();
    myFocusNode = FocusNode();
    _active = false;
  }

  @override
  void dispose(){
    usernameController.dispose();
    passwordController.dispose();
    addressController.dispose();
    emailController.dispose();
    phoneController.dispose();
    myFocusNode.dispose();

    _active = false;
    super.dispose();
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
              Text('Update Profile',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: usernameController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Enter your username',
                  labelText: 'Username',
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                controller: passwordController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.password),
                  hintText: 'Enter your password',
                  labelText: 'Password',
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                controller: addressController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.place),
                  hintText: 'Enter your address',
                  labelText: 'Address',
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                controller: emailController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.email),
                  hintText: 'Enter your e-mail',
                  labelText: 'E-mail',
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                controller: phoneController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.phone),
                  hintText: 'Enter your phone number',
                  labelText: 'Phone No.',
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: (){
                        setState((){
                          updateCustomer(usernameController.text, passwordController.text, addressController.text, emailController.text, phoneController.text);
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ManageAccount()),
                        );
                      },
                      child: const Text('Update'),
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