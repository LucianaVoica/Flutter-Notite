import 'package:flutter/material.dart';

//!TODO - de facut functional
class SearchCard extends StatelessWidget {
  const SearchCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          const Icon(Icons.search),
          const SizedBox(width: 10),
          Text('Search', style: Theme.of(context).textTheme.titleLarge),
        ],
      ),
    );
  }
}
