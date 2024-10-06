import 'package:flutter/material.dart';
import 'admin.dart';
import 'deleteProduct.dart';
import 'addProduct.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}): super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manage Products',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ManagePage(),
    );
  }
}

class ManagePage extends StatelessWidget {
  const ManagePage({Key? key}): super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text('Manage Products'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Edit Products'),
              Tab(text: 'Delete Products'),
              Tab(text: 'Add Products'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AdminPage(),
            DeleteProduct(),
            AddProduct(),
          ],
        ),
      ),
    );
  }
}
