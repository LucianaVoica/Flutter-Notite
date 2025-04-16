import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../categories/data/models/category_model.dart';
import '../../data/model/note_model.dart';
import '../bloc/note_bloc.dart';
import '../bloc/note_event.dart';
import 'add_note_form.dart';

class PinnedCard extends StatelessWidget {
  const PinnedCard({super.key, required this.note, required this.categories});

  final NoteModel note;
  final List<CategoryModel> categories;

  Color getCategoryColor(BuildContext context, String categoryName) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final String name = categoryName.toLowerCase().trim();

    switch (name) {
      case 'all':
        return colorScheme.primary;
      case 'work':
        return colorScheme.primaryContainer;
      case 'personal':
        return colorScheme.secondaryContainer;
      case 'shopping':
        return colorScheme.tertiaryContainer;
      case 'study':
        return colorScheme.errorContainer;
      default:
        return colorScheme.primaryContainer;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color baseColor = getCategoryColor(context, note.categoryName);
    final String shortenedContent =
        note.content.length > 50
            ? '${note.content.substring(0, 50)} ...'
            : note.content;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          AddNoteForm.route(note: note, categories: categories),
        ).then((_) {
          context.read<NoteBloc>().add(LoadPinnedNotes());
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                baseColor.withAlpha((255 * 0.7).toInt()),
                baseColor.withAlpha((255 * 0.2).toInt()),
              ],
              end: Alignment.topCenter,
              begin: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 8.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      note.categoryName,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(note.title),
                const SizedBox(height: 5),
                Text(
                  shortenedContent,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
