import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'signupcustomer.dart';
import 'customer.dart';
import 'loginadmin.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:ffi';



void main() => runApp(const LoginCustomer());

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

findCustomer(String username, String password) async {

  final response = await http.post(
      Uri.parse('http://192.168.0.139/bit311/logincustomer.php'),
      body: {
        'username': username,
        'password': password,
      }
  );
}

class LoginCustomer extends StatelessWidget {
  const LoginCustomer({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'COURTS',
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget{
  const MyApp({Key? key}): super(key: key);
  @override
  State<MyApp>createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  Future<Customer>? _futureCustomer;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  late FocusNode myFocusNode;
  late bool _active;

  Future<void> saveLoginDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', usernameController.text);
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
    myFocusNode.dispose();
    _active = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
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
                  MaterialPageRoute(builder: (context) => const MyHomePage()),
                );
              },
            ),

            ListTile(
              title: const Text('Sign Up as Customer'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpCustomer()),
                );
              },
            ),
            ListTile(
              title: const Text('Login as Customer'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginCustomer()),
                );
              },
            ),
            ListTile(
              title: const Text('Login as Admin'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginAdmin()),
                );
              },
            ),
          ],
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text('Login as Customer',
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

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the username';
                  }
                  return null;
                },
              ),

              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                controller: passwordController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.password),
                  hintText: 'Enter your password',
                  labelText: 'Password',
                ),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the password';
                  }
                  return null;
                },
              ),

              Padding(
                padding: EdgeInsets.all(28.0),
              ),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: (){
                        if (_formKey.currentState!.validate()){
                          setState((){
                            findCustomer(usernameController.text, passwordController.text);
                          });
                          saveLoginDetails();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const CustomerPage()),
                          );
                        }
                      },
                      child: const Text('Login'),
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

