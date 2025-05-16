import 'package:flutter/material.dart';

class DetaliiStare extends StatelessWidget {
  const DetaliiStare({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: const Column(
        children: <Widget>[
          Text('Card cu calendar si stari'),
          SizedBox(height: 5),
          Text('Card cu bara progresiva stari'),
        ],
      ),
    );
  }
}
