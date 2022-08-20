import 'package:brew_app/models/brew_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'brew_tile.dart';

class BrewList extends StatelessWidget {
  const BrewList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<BrewUser?>>(context);
    for (var e in brews) {
      print('This is the brew name: ${e!.name}');
      print('This is the sugars: ${e.sugars}');
    }
    return ListView.builder(
        itemCount: brews.length,
        itemBuilder: (context, index) => Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
              child: Card(
                child: BrewTile(brews: brews[index]),
              ),
            ));
    // return Container(
    //   child: Text(brews!.docs.map((doc) => doc.data()).toString()),
    // );
  }
}
