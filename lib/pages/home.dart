import 'package:flutter/material.dart';

import '../features/categorii/presentation/pages/category_list.dart';
import '../widget/avatar/avatar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.appTitle});
  static const String route = '/';

  final String appTitle;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.appTitle,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: false,
        titleTextStyle: Theme.of(context).textTheme.titleLarge,
        actions: const <Widget>[Avatar()],
      ),
      body: const Column(
        children: <Widget>[
          CategoryList(),
          Expanded(child: Center(child: Text('Aici vor fi notițele'))),
        ],
      ),
    );
  }
}
