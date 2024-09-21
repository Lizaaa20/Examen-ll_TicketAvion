import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firestore = Provider.of<FirebaseFirestore>(context);

    void _addData() {
      firestore.collection('test').add({
        'name': 'Flutter Firebase',
        'description': 'Integrating Firebase with Flutter',
      });
    }

    void _readData() {
      firestore.collection('test').get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          print(doc["name"]);
        });
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _addData,
              child: Text('Add Data'),
            ),
            ElevatedButton(
              onPressed: _readData,
              child: Text('Read Data'),
            ),
          ],
        ),
      ),
    );
  }
}
