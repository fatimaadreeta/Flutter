import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:convert';
import 'admin.dart';
import 'ViewAnalyticReport.dart';
import 'main.dart';

void main() => runApp(const AddProduct());

class Product{
  final String productId;
  final String productName;
  final String productDesc;
  final String price;

  Product({required this.productId, required this.productName, required this.productDesc, required this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['Id'],
      productName: json['proName'],
      productDesc: json['proDesc'],
      price: json['price'],
    );
  }
}
createProduct(String productName, String productDesc, String price) async {
  final response = await http.post(
      Uri.parse('http://192.168.0.139/bit311/addProduct.php'),
      body: {
        'productName': productName,
        'productDesc': productDesc,
        'price': price,
      }
  );
      if (response.statusCode == 200){
        print("Ok");
      } else {
        throw Exception('Unexpected error occured');
      }
}
class AddProduct extends StatelessWidget {
  const AddProduct({Key? key}) : super(key: key);

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
class _MyAppState extends State<MyApp> {

  Future<Product>? _futureProduct;
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final priceController = TextEditingController();

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
    nameController.dispose();
    descController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('COURTS'),
      ),
      drawer: Drawer(
        child: ListView(
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
                  MaterialPageRoute(builder: (context) => const AdminPage()),
                );
              },
            ),
            ListTile(
              title: const Text('Manage Products'),
              onTap: () {
// Update the state of the app
// ...
// Then close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AdminPage()),
                );
              },
            ),
            ListTile(
              title: const Text('View Analytic Report'),
              onTap: () {
// Update the state of the app
// ...
// Then close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ViewAnalyticReport()),
                );
              },
            ),
            ListTile(
              title: const Text('Logout'),
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
          ],
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const Text('Add new product',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),
              ),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.chair),
                  hintText: 'Add name of furniture',
                  labelText: 'Name',
                ),
                 validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter valid name';
                      }
                      return null;
                    },
              ),
              TextFormField(
                controller: descController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.description),
                  hintText: 'Add description',
                  labelText: 'Description',
                ),
                 validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter valid description';
                      }
                      return null;
                    },
              ),
              TextFormField(
                controller: priceController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.price_change_rounded),
                  hintText: 'Product price',
                  labelText: 'Price',
                ),
                validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter valid price';
                      }
                      return null;
                    },
              ),
              const Padding(
                padding: EdgeInsets.all(28.0),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: (){
                        if (_formKey.currentState!.validate()){
                          setState((){
                            createProduct(nameController.text,descController.text,priceController.text);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('added to database')));
                        }
                      },
                      child: const Text('Add Product'),
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