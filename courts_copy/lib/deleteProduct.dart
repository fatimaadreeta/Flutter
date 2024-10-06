import 'package:flutter/material.dart';
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

deleteProduct(String productId) async {

  final response = await http.post(
      Uri.parse('http://192.168.0.139/bit311/deleteProduct.php'),
      body: {
        'productId': productId
      }
  );

  if (response.statusCode == 200){
    print("Returned message: "+response.body.toString());
  } else {
    throw Exception('Unexpected error occured');
  }
}

class Product{
  final String productId;
  final String productName;
  final String productDesc;
  final String price;

  Product({required this.productId, required this.productName, required this.productDesc, required this.price});

  String getName()
  {
    return this.productName;
  }

  String getId()
  {
    return this.productId;
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['Id'],
      productName: json['proName'],
      productDesc: json['proDesc'],
      price: json['price'],
    );
  }
}

void main() => runApp(DeleteProduct());

class DeleteProduct extends StatelessWidget {
  const DeleteProduct({Key? key}): super(key: key);

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

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'COURTS',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Slide to Delete Products'),
        ),
        body: Center(
          child: FutureBuilder <List<Product>>(
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Product>? data = snapshot.data;

                return
                  ListView.builder(
                      itemCount: data?.length,
                      itemBuilder: (BuildContext context, int index){
                        final item = data?[index];
                        final productName = item!.getName();
                        return Dismissible(
                          key: Key(item!.getName()),

                          onDismissed: (direction){
                            //Remove the item from the datasource.
                            setState(() {
                              data?.removeAt(index);
                              deleteProduct(item!.getId());
                            });

                            //Then show a snack-bar.
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$productName removed from database')));
                          },
                          //show a red background as the item is swiped away
                          background: Container(color: Colors.red),

                          child: Center(
                            child: ProductCard(name:data![index].productName, description: data![index].productDesc, price: data![index].price),
                          ),
                        );
                      }
                  );
              } else if(snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              //By default show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

}

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key, required this.name, required this.description, required this.price}) :
        super(key: key);

  final String name;
  final String description;
  final String price;

  Widget build(BuildContext context){
    return Container(
        padding: EdgeInsets.all(5),
        height: 200,
        child: Card(
            child: new InkWell(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                      "Name: "+this.name, style: TextStyle(
                      fontWeight: FontWeight.bold
                  )
                  ),
                  Text("Description: "+this.description),
                  Text("Price: "+this.price+"RM",),
                ],
              ),
            )
        )
    );
  }
}