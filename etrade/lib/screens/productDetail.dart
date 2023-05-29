import 'package:etrade/db/dbHelper.dart';
import 'package:etrade/models/product.dart';
import 'package:etrade/screens/ProductUpdate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProductDetail extends StatefulWidget {
  Product product;
  ProductDetail(this.product);
  @override
  State<StatefulWidget> createState() => ProductDetailState(product);
}

DbHelper dbHelper = DbHelper();

enum Choice { Delete, Update }

class ProductDetailState extends State {
  Product product;
  ProductDetailState(this.product);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Detail for ${product.name}"),
        actions: <Widget>[
          PopupMenuButton(
              onSelected: select,
              itemBuilder: (BuildContext context) => <PopupMenuEntry<Choice>>[
                    PopupMenuItem<Choice>(
                      value: Choice.Delete,
                      child: Text("Delete ${product.name}"),
                    ),
                    PopupMenuItem<Choice>(
                      value: Choice.Update,
                      child: Text("Update ${product.name}"),
                    )
                  ])
        ],
      ),
      body: Center(
        child: Card(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.shop),
                title: Text(product.name),
                subtitle: Text(product.description),
              ),
              Text("${product.name} price is => ${product.price}"),
              ButtonTheme(
                  child: ButtonBar(
                children: <Widget>[addToCardButton()],
              ))
            ],
          ),
        ),
      ),
    );
  }

  void select(Choice choice) async {
    switch (choice) {
      case Choice.Delete:
        int result;
        Navigator.pop(context as BuildContext, true);
        result = await dbHelper.delete(product.id as int);
        if (result != 0) {
          AlertDialog alertDialog = AlertDialog(
            title: Text("Success!"),
            content: Text("${product.name} ${choice.name}d! "),
          );
          showDialog(
              context: context as BuildContext, builder: (_) => alertDialog);
        }
        break;
      case Choice.Update:
        AlertDialog alertDialog = AlertDialog(
          title: Text("I will go to update page!"),
          content: Text("${product.name} ${choice.name} page "),
        );
        showDialog(
            context: context as BuildContext, builder: (_) => alertDialog);
        break;
      default:
    }
  }

  Widget addToCardButton() {
    return ElevatedButton(
        onPressed: () {
          AlertDialog alertDialog = AlertDialog(
            title: Text("Success!"),
            content: Text("${product.name} added to card!"),
          );
          showDialog(
              context: context as BuildContext, builder: (_) => alertDialog);
        },
        child: Text("Add to card"));
  }
}
