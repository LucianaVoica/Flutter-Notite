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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TextField(
          controller: _controller,
          decoration: const InputDecoration(
            labelText: 'Nume categorie',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(onPressed: _addCategory, child: const Text('Adaugă')),
        const SizedBox(height: 10),
      ],
    );
  }
}
