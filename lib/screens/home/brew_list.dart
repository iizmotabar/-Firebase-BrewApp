import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BrewList extends StatelessWidget {
  const BrewList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<QuerySnapshot?>(context);

    for (var documents in brews!.docs) {
      print(documents.data.call());
    }
    return Container();
    // return Container(
    //   child: Text(brews!.docs.map((doc) => doc.data()).toString()),
    // );
  }
}
