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

  Widget getCategoryImage(String categoryName) {
    final String name = categoryName.toLowerCase().trim();
    switch (name) {
      case 'work':
        return Image.asset('assets/images/work.png', width: 80, height: 120);
      case 'personal':
        return Image.asset('assets/images/girl.png', width: 80, height: 120);
      case 'shopping':
        return Image.asset('assets/images/shop.png', width: 80, height: 120);
      case 'study':
        return Image.asset('assets/images/study.png', width: 80, height: 120);
      default:
        return Image.asset('assets/images/setup.png', width: 80, height: 120);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color baseColor = Theme.of(context).colorScheme.primaryContainer;
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
          height: 150,
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
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                getCategoryImage(note.categoryName),
                const SizedBox(width: 12),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Chip(
                        label: Text(
                          note.categoryName,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        padding: EdgeInsets.zero,
                        labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                        shape: const StadiumBorder(),
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
