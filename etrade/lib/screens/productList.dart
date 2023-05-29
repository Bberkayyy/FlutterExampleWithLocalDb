import 'package:etrade/db/dbHelper.dart';
import 'package:etrade/models/product.dart';
import 'package:etrade/screens/ProductUpdate.dart';
import 'package:etrade/screens/productDetail.dart';
import 'package:flutter/material.dart';

import 'ProductAdd.dart';

class ProductList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProductListState();
}

class ProductListState extends State {
  DbHelper dbHelper = DbHelper();
  List<Product>? products;
  int count = 0;
  @override
  Widget build(BuildContext context) {
    if (products == null) {
      products = <Product>[];
      getData();
    }
    return Scaffold(
      body: productListItems(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          goToProductAdd();
        },
        tooltip: "Add New Product",
        child: const Icon(Icons.add),
      ),
    );
  }

  ListView productListItems() {
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.amber,
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text("P"),
              ),
              title: Text(products![position].name),
              subtitle: Text(products![position].description),
              onTap: () {
                goToDetail(products![position]);
              },
            ),
          );
        });
  }

  void getData() {
    var dbFuture = dbHelper.initializeDb();
    dbFuture.then((value) {
      var productsFuture = dbHelper.getProducts();
      productsFuture.then((data) {
        List<Product> productsData = <Product>[];
        count = data.length;
        for (int i = 0; i < count; i++) {
          productsData.add(Product.fromObject(data[i]));
        }
        setState(() {
          products = productsData;
          count = count;
        });
      });
    });
  }

  void goToDetail(Product product) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => ProductDetail(product)));
    if (result == true) {
      getData();
    }
  }

  void goToProductAdd() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProductAdd()));
    if (result == true) {
      getData();
    }
  }

  void goToProductUpdate(Product product) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => ProductUpdate(product)));
    if (result == true) {
      getData();
    }
  }
}
