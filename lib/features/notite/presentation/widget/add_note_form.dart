import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../categories/data/models/category_model.dart';
import '../../data/model/note_model.dart';
import '../bloc/note_bloc.dart';
import '../bloc/note_event.dart';

class AddNoteForm extends StatefulWidget {
  const AddNoteForm({super.key, required this.categories, this.note});
  final List<CategoryModel> categories;
  final NoteModel? note;

  static MaterialPageRoute<dynamic> route({
    required List<CategoryModel> categories,
    NoteModel? note,
  }) => MaterialPageRoute<dynamic>(
    builder:
        (BuildContext context) =>
            AddNoteForm(categories: categories, note: note),
  );

  @override
  State<AddNoteForm> createState() => _AddNoteFormState();
}

class _AddNoteFormState extends State<AddNoteForm> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  final FocusNode _contentFocusNode = FocusNode();

  late String selectedCategoryId;
  late bool isPinned = false;

  Color _getCategoryColor(String? categoryId) {
    if (categoryId == '00000000-0000-0000-0000-000000000001') {
      return Colors.cyanAccent;
    }

    final List<Color> vibrantColors = <Color>[
      Colors.redAccent,
      Colors.orangeAccent,
      Colors.amberAccent,
      Colors.greenAccent,
      Colors.blueAccent,
      Colors.purpleAccent,
      Colors.pinkAccent,
    ];

    final int index = widget.categories.indexWhere(
      (CategoryModel category) => category.id == categoryId,
    );
    if (index == -1) {
      return Colors.cyanAccent;
    }

    return vibrantColors[index % vibrantColors.length];
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _contentController = TextEditingController(
      text: widget.note?.content ?? '',
    );
    selectedCategoryId =
        widget.note?.categoryId ?? '00000000-0000-0000-0000-000000000001';

    isPinned = widget.note?.isPinned ?? false;
  }

  void togglePinNote() {
    setState(() {
      isPinned = !isPinned;
    });

    if (widget.note != null) {
      context.read<NoteBloc>().add(
        PinNote(
          noteId: widget.note!.id,
          isPinned: isPinned,
          categoryId: selectedCategoryId,
        ),
      );
    }
  }

  void _showCategoryDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setDialogState) {
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
                    Text(
                      'Alege o categorie',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    const SizedBox(height: 20),
                    DropdownButton<String>(
                      isExpanded: true,
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
                          selectedCategoryId = value!;
                        });
                        setDialogState(() {});
                      },
                      style: const TextStyle(color: Colors.black),
                      dropdownColor: Colors.white,
                      iconSize: 30,
                      iconEnabledColor: Colors.black,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Confirmă'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _saveNote() {
    final NoteModel note = NoteModel(
      id: widget.note?.id ?? UniqueKey().toString(),
      title: _titleController.text,
      content: _contentController.text,
      categoryId: selectedCategoryId,
      isPinned: isPinned,
    );

    if (widget.note == null) {
      context.read<NoteBloc>().add(AddNote(note: note));
    } else {
      context.read<NoteBloc>().add(UpdateNote(note: note));
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        leading: IconButton(
          icon: const CircleAvatar(
            backgroundColor: Colors.black,
            radius: 20,
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
          onPressed: () => Navigator.pop(context),
        ),

        actions: <Widget>[
          IconButton(
            icon: CircleAvatar(
              backgroundColor: Colors.black,
              radius: 20,
              child: Icon(
                isPinned
                    ? Icons.bookmark
                    : Icons
                        .bookmark_border_outlined, // Schimbăm iconița în funcție de stare
                color: Colors.white,
              ),
            ),
            onPressed: togglePinNote,
          ),
          const SizedBox(width: 3),
          IconButton(
            icon: const CircleAvatar(
              backgroundColor: Colors.black,
              radius: 20,
              child: Icon(Icons.check, color: Colors.white),
            ),
            onPressed: _saveNote,
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
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _getCategoryColor(selectedCategoryId),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  widget.categories
                      .firstWhere(
                        (CategoryModel category) =>
                            category.id == selectedCategoryId,
                        orElse:
                            () => CategoryModel(
                              id: '',
                              name: 'All',
                              isSelected: false,
                            ),
                      )
                      .name,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ],
            ),
            const SizedBox(height: 16),

            Container(
              height: 60,
              width: 180,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
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
                style: Theme.of(context).textTheme.displayMedium,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                onFieldSubmitted: (_) {
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
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
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
