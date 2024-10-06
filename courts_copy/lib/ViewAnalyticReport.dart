import 'package:flutter/material.dart';
import 'main.dart';
import 'admin.dart';
import 'manageProduct.dart';

void main() => runApp(const ViewAnalyticReport());

class ViewAnalyticReport extends StatelessWidget {
  const ViewAnalyticReport({Key? key}): super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'COURTS',
      home: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}): super(key: key);

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
                  MaterialPageRoute(builder: (context) => const ManagePage()),
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
      body: const Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text('View Analytic Report',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),

              Padding(
                padding: EdgeInsets.all(1.0),
              ),

              Text('Monthly Sales Report',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                ),
              ),

              const MonthlySalesReport(),

              Padding(
                padding: EdgeInsets.all(15.0),
              ),

              Text('Yearly Sales Report',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                ),
              ),

              const YearlySalesReport(),
            ],
          ),
        ),
      ),
    );
  }
}

class MonthlySalesReport extends StatelessWidget {
  const MonthlySalesReport({super.key});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Expanded(
            child: Text(
              'Month',
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Total Sales',
            ),
          ),
        ),
      ],
      rows: const <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(Text('January')),
            DataCell(Text('RM1000')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('February')),
            DataCell(Text('RM1000')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('March')),
            DataCell(Text('RM1000')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('April')),
            DataCell(Text('RM1000')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('May')),
            DataCell(Text('RM1000')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('June')),
            DataCell(Text('RM1000')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('July')),
            DataCell(Text('RM1000')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('August')),
            DataCell(Text('RM1000')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('September')),
            DataCell(Text('RM1000')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('October')),
            DataCell(Text('RM1000')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('November')),
            DataCell(Text('RM1000')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('December')),
            DataCell(Text('RM1000')),
          ],
        ),
      ],
    );
  }
}

class YearlySalesReport extends StatelessWidget {
  const YearlySalesReport({super.key});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Expanded(
            child: Text(
              'Year',
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Total Sales',
            ),
          ),
        ),
      ],
      rows: const <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(Text('2024')),
            DataCell(Text('RM10000')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('2025')),
            DataCell(Text('RM20000')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('2026')),
            DataCell(Text('RM30000')),
          ],
        ),
      ],
    );
  }
}