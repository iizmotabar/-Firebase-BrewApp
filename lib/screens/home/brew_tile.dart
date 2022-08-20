import 'package:flutter/material.dart';

import '../../models/brew_user.dart';

class BrewTile extends StatelessWidget {
  final BrewUser? brews;
  const BrewTile({Key? key, required this.brews}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        // margin: const EdgeInsets.fromLTRB(10, 6, 100, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[brews!.strength],
          ),
          title: Text(brews!.name),
          subtitle: Text("Sugars: ${brews!.sugars}"),
        ),
      ),
    );
  }
}
