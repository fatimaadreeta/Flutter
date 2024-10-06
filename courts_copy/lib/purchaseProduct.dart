import 'dart:convert';
import 'dart:ffi';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:courts_copy/checkout.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'ManageAccount.dart';
import 'orderedFurniture.dart';
import 'main.dart';
import 'customer.dart';

/*Stripe.publishableKey =
'pk_test_51Oy3HnP8HLhMmjpSWTC6i9qSy73wcMP57sdacrHWXxRytWREcUeBah9vbXe0TkaowB5BnpXnEtFVGf52wUyszG4G00awdo06OJ';*/

class Purchase {
  final String purchaseid;
  final String username;
  final String productid;
  final String quantity;
  final String status;


  Purchase(
      {required this.purchaseid, required this.username, required this.productid, required this.quantity, required this.status});

  factory Purchase.fromJson(Map<String, dynamic> json){
    return Purchase(
      purchaseid: json['purchaseId'],
      username: json['Username'],
      productid: json['ProductId'],
      quantity: json['quantity'],
      status: json['status'],
    );
  }
}

createPurchase(String username, String productid, String quantity, String status) async {

  final response = await http.post(
      Uri.parse('http://192.168.0.139/bit311/addPurchase.php'),
      body: {
        'username': username,
        'productid': productid,
        'quantity': quantity,
        'status': status,
      }
  );
}

class PurchaseProduct extends StatefulWidget {
  final String id;
  final String image;

  PurchaseProduct(this.id, this.image, {super.key});

  @override
  State<PurchaseProduct>createState() => _MyAppState();

}

class _MyAppState extends State<PurchaseProduct>{
  Future<Purchase>? _futurePurchase;
  String? customer;
  String? productid;
  String? productname;
  String imageName = '';
  int quantity = 1;

  Future<void> loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      customer = prefs.getString('username');
    });
  }
  Future<void> loadProduct() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      productid = prefs.getString('productId');
    });
  }
  Future<void> loadProductName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      productname = prefs.getString('productName');
    });
  }
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }


  @override
  void initState(){
    imageName = widget.image;
    loadUsername();
    loadProduct();
    loadProductName();
    super.initState();
  }

  @override
  void dispose(){

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
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('you are currently purchasing')));
              },
            ),
            ListTile(
              title: const Text('Make Payment'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('purchase procedure incomplete')));
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
      body: Column(
        children: <Widget>[
      Padding(
      padding: EdgeInsets.all(28.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Id: "),
          Text(productid!,
              style: const TextStyle(
              fontWeight: FontWeight.bold
          )
          ),
          Text("     "),
          Text("Product Name: "),
          Text(productname!,
              style: const TextStyle(
                  fontWeight: FontWeight.bold
              )
          ),
          ],
      ),
      ),
          // Image
          Container(
            child: Image.asset("assets/images/"+imageName,
            height: 200,
            width: 250),
            ),
          // Quantity row
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: decrementQuantity,
                ),
                Text(
                  '$quantity',
                  style: TextStyle(fontSize: 20.0),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: incrementQuantity,
                ),
              ],
            ),
          ),
          // Purchase button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              Semantics(
                label: "Purchase button",
                hint: "Press to buy items",
              child: ElevatedButton(
                onPressed: () {
                  loadUsername();
                  loadProduct();
                  setState(() {
                    String status ="Purchased";
                    createPurchase(customer!, productid!.toString(), quantity.toString(), status);
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CheckOut()),
                  );
                },
                child: Text('Purchase'),
              ),
              ),
              Text("    "),
              Semantics(
                  label: "Cancel button",
                  hint: "Press to cancel purchase",
                  child:ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CustomerPage()),
                  );
                },
                child: Text('Cancel'),
              ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
