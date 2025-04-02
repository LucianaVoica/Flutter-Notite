import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/category_model.dart';
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addCategory() {
    if (_controller.text.isNotEmpty) {
      context.read<CategoryBloc>().add(
        AddCategory(
          category: CategoryModel(
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
          Text(
            'Adaugă categorie',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _controller,
            decoration: const InputDecoration(labelText: 'Nume categorie'),
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
