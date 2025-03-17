import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/category_model.dart';
import '../bloc/category_bloc.dart';
import '../bloc/category_event.dart';

class AddCategoryForm extends StatefulWidget {
  const AddCategoryForm({super.key});

  @override
  AddCategoryFormState createState() => AddCategoryFormState();
}

class AddCategoryFormState extends State<AddCategoryForm> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void _addCategory() {
    if (_controller.text.isNotEmpty) {
      context.read<CategoryBloc>().add(
        AddCategory(
          category: Category(
            id: UniqueKey().toString(),
            name: _controller.text,
            isSelected: false,
          ),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Adauga categorie', style: TextStyle(fontSize: 20)),
          const SizedBox(height: 10),
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Nume categorie',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _addCategory,
            style: Theme.of(context).elevatedButtonTheme.style,
            child: const Text('Adaugă'),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
