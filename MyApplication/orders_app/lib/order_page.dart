import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'add_order_page.dart';

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: OrderList(),  // Reference to the OrderList widget
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddOrderPage()),  // Navigate to AddOrderPage when the + button is pressed
          );
        },
      ),
    );
  }
}

class OrderList extends StatelessWidget {
  final CollectionReference orders = FirebaseFirestore.instance.collection('orders');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: orders.snapshots(),  // Listen to the Firebase Firestore collection updates
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());  // Show a loading indicator if there's no data
        }

        return ListView(
          children: snapshot.data!.docs.map((document) {  // Display the list of orders
            return ListTile(
              title: Text(document['dish_name']),
              subtitle: Text('Votes: ${document['votes']}, Quantity: ${document['quantity']}'),
              trailing: Text(document['note']),
            );
          }).toList(),
        );
      },
    );
  }
}
