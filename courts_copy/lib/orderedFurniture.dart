import 'package:flutter/material.dart';
import 'main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'customer.dart';
import 'ManageAccount.dart';
import 'nearestStores.dart';
import 'purchaseProduct.dart';

void main() => runApp(ViewOrderedFurniture());

class ViewOrderedFurniture extends StatelessWidget {

  const ViewOrderedFurniture({Key? key}): super(key: key);

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

  final descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
    descriptionController.dispose();
    myFocusNode.dispose();
    _active = false;
    super.dispose();
  }

  int selectedOption = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('COURTS'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              child: Text('COURTS'),
            ),

            ListTile(
              title: const Text('Home'),
              onTap: () {
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ViewOrderedFurniture()),
                );
              },
            ),
            ListTile(
              title: const Text('Find Nearest Store'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NearestStore()),
                );
              },
            ),
            ListTile(
              title: const Text('Manage Account'),
              onTap: () {
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
              Text('View Ordered Furniture',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),

              Padding(
                padding: EdgeInsets.all(5.0),
              ),

              const OrderedFurniture(),

              Padding(
                padding: EdgeInsets.all(5.0),
              ),

              Text('Review Furniture',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),

              ListTile(
                title: const Text('1 star'),
                leading: Radio<int>(
                  value: 1,
                  groupValue: selectedOption,
                  splashRadius: 20, // Change the splash radius when clicked
                  onChanged: (value) {
                    setState(() {
                      selectedOption = 1;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('2 stars'),
                leading: Radio<int>(
                  value: 2,
                  groupValue: selectedOption,
                  splashRadius: 25, // Change the splash radius when clicked
                  onChanged: (value) {
                    setState(() {
                      selectedOption = 2;
                    });
                  },
                ),
              ),

              ListTile(
                title: const Text('3 stars'),
                leading: Radio<int>(
                  value: 3,
                  groupValue: selectedOption,
                  splashRadius: 25, // Change the splash radius when clicked
                  onChanged: (value) {
                    setState(() {
                      selectedOption = 3;
                    });
                  },
                ),
              ),

              ListTile(
                title: const Text('4 stars'),
                leading: Radio<int>(
                  value: 4,
                  groupValue: selectedOption,
                  splashRadius: 25, // Change the splash radius when clicked
                  onChanged: (value) {
                    setState(() {
                      selectedOption = 4;
                    });
                  },
                ),
              ),

              ListTile(
                title: const Text('5 stars'),
                leading: Radio<int>(
                  value: 5,
                  groupValue: selectedOption,
                  splashRadius: 25, // Change the splash radius when clicked
                  onChanged: (value) {
                    setState(() {
                      selectedOption = 5;
                    });
                  },
                ),
              ),

              TextFormField(
                keyboardType: TextInputType.text,
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Review Description',
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ViewOrderedFurniture()),
                        );
                      },
                      child: const Text('Review Furniture'),
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

class OrderedFurniture extends StatelessWidget {
  const OrderedFurniture({super.key});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Expanded(
            child: Text(
              'Furniture',
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Quantity',
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Rating',
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Review Description',
            ),
          ),
        ),
      ],
      rows: const <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Table')),
            DataCell(Text('1')),
            DataCell(Text('5 stars')),
            DataCell(Text('Excellent!')),
          ],
        ),

        DataRow(
          cells: <DataCell>[
            DataCell(Text('Chair')),
            DataCell(Text('1')),
            DataCell(Text('5 stars')),
            DataCell(Text('Very Good!')),
          ],
        ),

        DataRow(
          cells: <DataCell>[
            DataCell(Text('Bed')),
            DataCell(Text('1')),
            DataCell(Text('5 stars')),
            DataCell(Text('Good')),
          ],
        ),
      ],
    );
  }
}