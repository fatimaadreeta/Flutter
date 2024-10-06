import 'package:courts_copy/purchaseProduct.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ManageAccount.dart';
import 'package:flutter/material.dart';
import 'orderedFurniture.dart';
import 'main.dart';
import 'logincustomer.dart';
import 'nearestStores.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future <List<Product>> fetchData() async {
	final response = await http.get(Uri.parse('http://192.168.0.139/bit311/productsjson.php'));
    if (response.statusCode == 200){
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((data) => new Product.fromJson(data)).toList();
    }else{
        throw Exception('Unexpected error occured');
    }
  }

  class Product{
  final String productId;
  final String productName;
  final String productDesc;
  final String price;
  final String imageName;

  Product({required this.productId, required this.productName, required this.productDesc, required this.price, required this.imageName});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['Id'],
      productName: json['proName'],
      productDesc: json['proDesc'],
      price: json['price'],
      imageName: json['imageName'],
    );
  }
}

void main(){
  runApp(const CustomerPage());
}

class CustomerPage extends StatelessWidget {
  const CustomerPage({Key? key}): super(key: key);
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
    late Future <List<Product>> futureData;

    Future<void> logout() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    }

    //saving detail for future access
    Future<void> saveProductDetails(productid, productName) async {
      SharedPreferences prodId = await SharedPreferences.getInstance();
      await prodId.setString('productId', productid);
      SharedPreferences prodName = await SharedPreferences.getInstance();
      await prodName.setString('productName', productName);
    }

  @override
  void initState() {
      super.initState();
      futureData = fetchData();
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
                // Update the state of the app
                // ...
                // Then close the drawer
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Select a product first')));
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NearestStore()),
                );
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
      body: Center(
  child: FutureBuilder <List<Product>>(
  future: futureData,
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      List<Product>? data = snapshot.data;
      return ListView.builder(
        itemCount: data?.length,
        itemBuilder: (BuildContext context, int index){
          return GestureDetector(
          onTap: () {
            saveProductDetails(data![index].productId.toString(), data![index].productName);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PurchaseProduct(data![index].productId.toString(), data![index].imageName)),
            );
          },
          child:Container(
              constraints: BoxConstraints(
                maxHeight: 200,
                maxWidth: 200,
              ),
              child: Card(
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.asset("assets/images/${data![index].imageName}"),
                Expanded(
                child: Container(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Row(
                          children: [
                            Text(
                              "Id: ",
                              style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                              )
                          ),
                              Text(
                              data![index].productId,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold
                              )
                            ),
                            Text(
                                "    " + data![index].productName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold
                                )
                            ),
                          ]
                        ),
                        Text(data![index].productDesc),
                        Text(
                            "Price: " + data![index].price + "RM"
                        ),
                      ],
                    )
                  )
                )
              ]
              )
          )));
          }
        );
    } else if(snapshot.hasError) {
      return Text("${snapshot.error}");
    }
    //By default show a loading spinner.
    return const CircularProgressIndicator();
     },
    ),
  ),
 );
}
}