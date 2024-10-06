import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'main.dart';
import 'logincustomer.dart';
import 'loginadmin.dart';
import 'dart:convert';


void main() => runApp(const SignUpCustomer());

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

createCustomer(String username, String password) async {

  final response = await http.post(
      Uri.parse('http://192.168.0.139/bit311/signupcustomer.php'),
      body: {
        'username': username,
        'password': password,
      }
  );
}

class SignUpCustomer extends StatelessWidget {
  const SignUpCustomer({Key? key}): super(key: key);

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
        child:SingleChildScrollView(
            child: Column(
                children: <Widget>[
                  Text('Sign Up as Customer',
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
                                createCustomer(usernameController.text, passwordController.text);
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginCustomer()),
                              );
                            }
                          },
                          child: const Text('Sign Up'),
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
