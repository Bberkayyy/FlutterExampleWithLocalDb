import 'package:etrade/db/dbHelper.dart';
import 'package:etrade/models/product.dart';
import 'package:etrade/screens/productDetail.dart';
import 'package:flutter/material.dart';

class ProductUpdate extends StatefulWidget {
  Product product;
  ProductUpdate(this.product, {super.key});

  @override
  State<StatefulWidget> createState() => ProductUpdateState(product);
}

class ProductUpdateState extends State {
  Product product;
  ProductUpdateState(this.product);
  DbHelper dbHelper = DbHelper();
  TextEditingController txtId = TextEditingController();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtDescription = TextEditingController();
  TextEditingController txtPrice = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Update ${product.name}"),
        ),
        body: Form(
            child: Column(
          children: <Widget>[
            productNameField(),
            const Padding(
                padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0)),
            productDescription(),
            const Padding(
                padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0)),
            productPrice(),
            const Padding(
                padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0)),
            updateButton(),
          ],
        )));
  }

  void update() async {
    await dbHelper.update(Product(txtName.text, txtDescription.text,
        double.tryParse(txtPrice.text) ?? 0.0));
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => ProductDetail(product)));
    if (result != 0) {
      Navigator.pop(context, true);
    }
  }

  Widget productNameField() {
    return TextFormField(
      controller: txtName,
      decoration:
          InputDecoration(labelText: product.name, hintText: "Enter new name"),
    );
  }

  Widget productDescription() {
    return TextFormField(
      controller: txtDescription,
      decoration: InputDecoration(
          labelText: product.description, hintText: "Enter new description"),
    );
  }

  Widget productPrice() {
    return TextFormField(
      controller: txtPrice,
      decoration: InputDecoration(
          labelText: "${product.price}", hintText: "Enter new price"),
    );
  }

  Widget updateButton() {
    return ElevatedButton(
        onPressed: () {
          update();
        },
        child: const Text("Update"));
  }
}
