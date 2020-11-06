import 'package:flutter/material.dart';
import 'package:sqflite_app/data/dbHelper.dart';
import 'package:sqflite_app/models/product.dart';

class ProductAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProductAddState();
  }
}

class ProductAddState extends State {
  var dbHelper = DbHelper();
  var txtName = TextEditingController();
  var txtDesc = TextEditingController();
  var txtUnitP = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: [
            buildNameField(),
            buildDescField(),
            buildUnitPriceField(),
            buildSaveButton(),
          ],
        ),
      ),
    );
  }

  buildNameField() {
    return TextField(
      decoration: InputDecoration(labelText: "Name"),
      controller: txtName,
    );
  }

  buildDescField() {
    return TextField(
      decoration: InputDecoration(labelText: "Description"),
      controller: txtDesc,
      maxLines: 4,
      minLines: 2,
    );
  }

  buildUnitPriceField() {
    return TextField(
      decoration: InputDecoration(labelText: "Unit Price"),
      controller: txtUnitP,
    );
  }

  buildSaveButton() {
    return FlatButton(
        onPressed: () {
          addProduct();
        },
        child: Text("Add"));
  }

  void addProduct() async {
    var result = await dbHelper.insert(Product(
        name: txtName.text,
        description: txtDesc.text,
        unitPrice: double.tryParse(txtUnitP.text))).toString();
    Navigator.pop(context , true);
  }
}
