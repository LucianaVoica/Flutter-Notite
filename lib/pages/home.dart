import 'package:flutter/material.dart';
import '../features/categorii/presentation/widget/category_list.dart';
import '../theme/gradient.dart';
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          widget.appTitle,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: false,
        titleTextStyle: Theme.of(context).textTheme.titleLarge,
        actions: const <Widget>[Avatar()],
        backgroundColor: const Color(0xFFF7E7CE),
      ),
      body: const GradientBackground(
        child: Column(
          children: <Widget>[
            CategoryList(),
            Expanded(child: Center(child: Text('Aici vor fi notițele'))),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => (),
        backgroundColor: Theme.of(context).primaryColor,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 30, color: Colors.black),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
