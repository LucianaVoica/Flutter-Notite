import 'package:flutter/material.dart';

import '../widget/avatar/avatar.dart';
import '../widget/category/category_list.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key, required this.appTitle});
  static const String route = '/';

  final String appTitle;

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
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
