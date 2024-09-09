import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddOrderPage extends StatefulWidget {
  @override
  _AddOrderPageState createState() => _AddOrderPageState();
}

class _AddOrderPageState extends State<AddOrderPage> {
  final TextEditingController _dishNameController = TextEditingController();
  final TextEditingController _votesController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  final CollectionReference orders = FirebaseFirestore.instance.collection('orders');

  Future<void> addOrder() {
    return orders
        .add({
      'dish_name': _dishNameController.text,
      'votes': int.parse(_votesController.text),
      'quantity': int.parse(_quantityController.text),
      'note': _noteController.text,
    })
        .then((value) => print("Order Added"))
        .catchError((error) => print("Failed to add order: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Order'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _dishNameController,
              decoration: InputDecoration(labelText: 'Dish Name'),
            ),
            TextField(
              controller: _votesController,
              decoration: InputDecoration(labelText: 'Votes'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _quantityController,
              decoration: InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _noteController,
              decoration: InputDecoration(labelText: 'Note'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                addOrder();
                Navigator.pop(context);  // Return to previous page after adding the order
              },
              child: Text('Add Order'),
            ),
          ],
        ),
      ),
    );
  }
}
