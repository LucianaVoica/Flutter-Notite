import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../categorii/data/category_model.dart';
import '../../data/model/note_model.dart';
import '../bloc/note_bloc.dart';
import '../bloc/note_event.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key, required this.categories});

  final List<CategoryModel> categories;

  @override
  AddNotePageState createState() => AddNotePageState();
}

class AddNotePageState extends State<AddNotePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  String? _selectedCategoryId;

  void _saveNote() {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Titlul este obligatoriu!')));
      return;
    }

    final NoteModel note = NoteModel(
      id: UniqueKey().toString(),
      title: _titleController.text,
      content: _contentController.text,
      categoryId: _selectedCategoryId ?? '1',
    );

    context.read<NoteBloc>().add(AddNote(note: note));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adaugă Notiță')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Titlu Notiță'),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Categorie'),
              value: _selectedCategoryId,
              items:
                  widget.categories
                      .where((CategoryModel cat) => cat.id != '1')
                      .map(
                        (CategoryModel cat) => DropdownMenuItem(
                          value: cat.id,
                          child: Text(cat.name),
                        ),
                      )
                      .toList(),
              onChanged:
                  (String? value) => setState(() {
                    _selectedCategoryId = value;
                  }),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: TextField(
                controller: _contentController,
                maxLines: null,
                expands: true,
                decoration: const InputDecoration(
                  labelText: 'Conținut Notiță',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _saveNote,
              child: const Text('Salvează Notița'),
            ),
          ],
        ),
      ),
    );
  }
}
