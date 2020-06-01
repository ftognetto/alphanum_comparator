

import 'package:alphanum_comparator/alphanum_comparator.dart';
import 'package:flutter/material.dart';

void main() {

  final List<String> _unsorted = ["Item 2", "Item 3", "Item 10", "Item 1"];
  final List<String> _sorted = _unsorted;
  _sorted.sort(AlphanumComparator.compare);

  runApp(
    MaterialApp(
      home: Scaffold(
        body: ListView(
          children: <Widget>[
            ListTile(title: Text('Unsorted Strings')),
            ..._unsorted.map((i) => ListTile(title: Text('$i'))).toList(),
            ListTile(title: Text('Sorted Strings')),
            ..._sorted.map((i) => ListTile(title: Text('$i'))).toList(),
          ],
        )
      ),
    )
  );
}