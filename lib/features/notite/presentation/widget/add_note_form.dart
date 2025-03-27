import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../theme/app_colors.dart';
import '../../../categorii/data/category_model.dart';
import '../../data/model/note_model.dart';
import '../bloc/note_bloc.dart';
import '../bloc/note_event.dart';

class AddNoteForm extends StatefulWidget {
  const AddNoteForm({super.key, required this.categories});
  final List<CategoryModel> categories;

  static MaterialPageRoute<dynamic> route({
    required List<CategoryModel> categories,
  }) => MaterialPageRoute<dynamic>(
    builder: (BuildContext context) => AddNoteForm(categories: categories),
  );

  @override
  State<AddNoteForm> createState() => _AddNoteFormState();
}

class _AddNoteFormState extends State<AddNoteForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  final FocusNode _contentFocusNode = FocusNode();

  String? selectedCategoryId;

  void _addNote() {
    context.read<NoteBloc>().add(
      AddNote(
        note: NoteModel(
          id: UniqueKey().toString(),
          title: _titleController.text,
          content: _contentController.text,
          categoryId:
              selectedCategoryId ?? '00000000-0000-0000-0000-000000000001',
        ),
      ),
    );
    Navigator.pop(context);
  }

  void _showCategoryDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Alege o categorie',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                DropdownButton<String>(
                  isExpanded: true,
                  hint: const Text('Categorie'),
                  value: selectedCategoryId,
                  items:
                      widget.categories.map((CategoryModel category) {
                        return DropdownMenuItem<String>(
                          value: category.id,
                          child: Text(category.name),
                        );
                      }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedCategoryId = value;
                    });
                  },
                  style: const TextStyle(color: Colors.black),
                  dropdownColor: Colors.white,
                  iconSize: 30,
                  iconEnabledColor: Colors.black,
                ),

                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (selectedCategoryId != null) {
                      Navigator.pop(context); // Închide dialogul
                    } else {
                      // Optional: poți adăuga un mesaj de eroare aici
                    }
                  },
                  child: const Text('Confirmă'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const CircleAvatar(
            backgroundColor: Colors.black,
            radius: 20,
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
          onPressed: () => Navigator.pop(context),
        ),

        backgroundColor: AppColors.secondaryLight,
        actions: <Widget>[
          IconButton(
            icon: const CircleAvatar(
              backgroundColor: Colors.black,
              radius: 20,
              child: Icon(Icons.check, color: Colors.white),
            ),
            onPressed: _addNote,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Nota',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),
            Container(
              height: 60,
              width: 180,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 243, 211, 169),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: const CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 20,
                      child: Icon(
                        Icons.bookmark_border_outlined,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () => (),
                  ),
                  const SizedBox(width: 5),
                  IconButton(
                    icon: const CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 20,
                      child: Icon(
                        Icons.favorite_border_outlined,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () => (),
                  ),
                  const SizedBox(width: 5),
                  IconButton(
                    icon: const CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 20,
                      child: Icon(Icons.folder_outlined, color: Colors.white),
                    ),
                    onPressed: _showCategoryDialog,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 20,
              child: TextFormField(
                controller: _titleController,
                textAlignVertical: TextAlignVertical.top,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color.fromARGB(255, 236, 197, 147),
                ),
                onFieldSubmitted: (_) {
                  // Când apesi Enter, focusul trece la câmpul de conținut
                  FocusScope.of(context).requestFocus(_contentFocusNode);
                },
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: TextFormField(
                  controller: _contentController,
                  maxLines: null,
                  textAlignVertical: TextAlignVertical.top,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
