import 'dart:convert';
import 'dart:io';
import 'package:courts_copy/addProduct.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'admin.dart';
import 'ViewAnalyticReport.dart';
import 'main.dart';

class ProductEditPage extends StatefulWidget {
  final String productId;
  final String productName;
  final String productDesc;
  final String price;
  final String imageName;

  ProductEditPage(this.productId, this.productName, this.productDesc, this.price, this.imageName, {super.key});

  @override
  _ProductEditPageState createState() => _ProductEditPageState();
}

class _ProductEditPageState extends State<ProductEditPage> {

  TextEditingController Id = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  XFile? _imageFile;

// Function to pick image from gallery or camera
  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _imageFile = pickedFile;
      imageController.text =
          pickedFile.name; // Set image name
    }
  }

  Future<void> saveChanges() async {
    try{
      String url = 'http://192.168.0.139/bit311/editProduct.php';
      var res = await http.post(Uri.parse(url), body: {
        'productId': Id.text,
        'productName': nameController.text,
        'productDesc': descController.text,
        'price': priceController.text,
        'imageName': imageController.text
      });
      var response = jsonDecode(res.body);
      if(response["success"] == "true"){
        print("updated");
      }
      else{
        print("error");
      }
    }catch(e){
      print(e);}
  }

  @override
  void initState() {
    Id.text = widget.productId;
    nameController.text = widget.productName;
    descController.text= widget.productDesc;
    priceController.text= widget.price;
    imageController.text= widget.imageName;
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
                  MaterialPageRoute(builder: (context) => const AdminPage()),
                );
              }
            ),

            ListTile(
              title: const Text('Manage Products'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddProduct()),
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
    child:SingleChildScrollView(
        child: Column(
          children: [
        const Text('Edit product ',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),
        ),
            TextFormField(
              controller: Id,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Product ID',
                  border: OutlineInputBorder(),
                ),
            ),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name',
                icon: Icon(Icons.chair),
                hintText: 'Edit name of furniture',),
            ),
            TextFormField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'Description',
                icon: Icon(Icons.description),
                hintText: 'Edit description',),
            ),
            TextFormField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Price',
                icon: Icon(Icons.price_change_rounded),
                hintText: 'Edit Product price',),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
            ),
// Image picker button
            ElevatedButton(
              onPressed: _pickImage,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.image),
                  SizedBox(width: 2),
                  Text("Pick Furniture Image"),
                ],
              ),
            ),
// Text field to display image name
            TextFormField(
              controller: imageController,
              readOnly: true, // Make the field read-only
              decoration: const InputDecoration(
                icon: Icon(Icons.image),
                labelText: "Image",
              ),
            ),
// Display the picked image
            if (_imageFile != null)
              Image.file(File(_imageFile!.path),
                  width: 200,
                  height: 150),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.all(28.0),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                saveChanges();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AdminPage()),
                );
              },
              child: const Text('Save changes'),
            ),
          ],
        ),
    ),
      ),
    );
  }
}
