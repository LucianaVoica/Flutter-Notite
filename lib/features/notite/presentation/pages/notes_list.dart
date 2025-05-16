import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/colors/app_colors.dart';
import '../../../categories/data/models/category_model.dart';
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocBuilder<NoteBloc, NoteState>(
        builder: (BuildContext context, NoteState state) {
          if (state is NoteLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is NoteLoaded) {
            if (state.notes.isEmpty) {
              return const Center(child: Text('Nu au fost introduse notițe'));
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
                    ).then((_) {
                      context.read<NoteBloc>().add(LoadPinnedNotes());
                    });
                  },

                  child: Dismissible(
                    key: Key(note.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: AppColors.errorLight,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (DismissDirection direction) {
                      context.read<NoteBloc>().add(
                        DeleteNote(
                          noteId: note.id,
                          categoryId: note.categoryId,
                        ),
                      );
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

          return Center(
            child: Text(
              'Eroare la încărcarea notițelor',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.errorLight),
            ),
          );
        },
      ),
    );
  }
}
