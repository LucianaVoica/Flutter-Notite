import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../theme/app_colors.dart';
import '../../../categorii/data/category_model.dart';
import '../../data/model/note_model.dart';
import '../bloc/note_bloc.dart';
import '../bloc/note_event.dart';
import '../bloc/note_state.dart';
import '../widget/add_note_form.dart';
import '../widget/note.dart';

class ListaNotite extends StatelessWidget {
  const ListaNotite({
    super.key,
    required this.categoryType,
    required this.categories,
  });

  static MaterialPageRoute<dynamic> route({
    required String categoryType,
    required List<CategoryModel> categories,
  }) => MaterialPageRoute<dynamic>(
    builder:
        (BuildContext context) =>
            ListaNotite(categoryType: categoryType, categories: categories),
  );

  final String categoryType;
  final List<CategoryModel> categories;

  @override
  Widget build(BuildContext context) {
    context.read<NoteBloc>().add(LoadNotes(categoryId: categoryType));

    return Scaffold(
      backgroundColor: AppColors.secondaryLight,
      appBar: AppBar(backgroundColor: AppColors.secondaryLight),
      body: BlocBuilder<NoteBloc, NoteState>(
        builder: (BuildContext context, NoteState state) {
          if (state is NoteLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is NoteLoaded) {
            if (state.notes.isEmpty) {
              return const Center(
                child: Text(
                  'Nu au fost introduse notițe',
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: state.notes.length,
              itemBuilder: (BuildContext context, int index) {
                final NoteModel note = state.notes[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      AddNoteForm.route(categories: categories, note: note),
                    );
                  },
                  child: Dismissible(
                    key: Key(note.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (DismissDirection direction) {
                      context.read<NoteBloc>().add(DeleteNote(noteId: note.id));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Notița a fost ștearsă')),
                      );
                    },
                    child: Note(note: note),
                  ),
                );
              },
            );
          }

          return const Center(
            child: Text(
              'Eroare la încărcarea notițelor',
              style: TextStyle(fontSize: 18, color: Colors.red),
            ),
          );
        },
      ),
    );
  }
}
