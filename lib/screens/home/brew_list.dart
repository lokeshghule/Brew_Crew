import 'package:brew_crew/models/brew.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// class BrewList extends StatefulWidget {
//   const BrewList({Key? key}) : super(key: key);

//   @override
//   _BrewListState createState() => _BrewListState();
// }

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context);

    brews.forEach((element) {
      print(element.name);
      print(element.sugers);
      print(element.strength);
    });
    return Container();
  }
}
