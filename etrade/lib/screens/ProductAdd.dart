import 'package:etrade/db/dbHelper.dart';
import 'package:etrade/models/product.dart';
import 'package:flutter/material.dart';

class ProductAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProductAddState();
}

class ProductAddState extends State {
  DbHelper dbHelper = DbHelper();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtDescription = TextEditingController();
  TextEditingController txtPrice = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add a new product"),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
          child: Column(children: <Widget>[
            productNameField(),
            productDescriptionField(),
            productPriceField(),
            saveButton(),
          ]),
        ));
  }

  void save() async {
    int result = await dbHelper.insert(Product(txtName.text,
        txtDescription.text, double.tryParse(txtPrice.text) ?? 0.0));
    if (result != 0) {
      Navigator.pop(context, true);
    }
  }

  Widget productNameField() {
    return TextField(
      controller: txtName,
      decoration: InputDecoration(labelText: "Name", hintText: "Product Name"),
    );
  }

  Widget productDescriptionField() {
    return TextField(
      controller: txtDescription,
      decoration: InputDecoration(
          labelText: "Description", hintText: "Product Description"),
    );
  }

  Widget productPriceField() {
    return TextField(
      controller: txtPrice,
      decoration:
          InputDecoration(labelText: "Price", hintText: "Product Price"),
    );
  }

  Widget saveButton() {
    return ElevatedButton(
        onPressed: () {
          save();
        },
        child: Text("Add"));
  }
}
