import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../categories/data/models/category_model.dart';
import '../../data/model/note_model.dart';
import '../bloc/note_bloc.dart';
import '../bloc/note_state.dart';
import '../widget/pinned_card.dart';

class NotesPinList extends StatelessWidget {
  const NotesPinList({super.key, required this.categories});
  final List<CategoryModel> categories;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (BuildContext context, NoteState state) {
        if (state is NoteLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is NoteLoaded) {
          final List<NoteModel> pinnedNotes =
              state.notes.where((NoteModel note) => note.isPinned).toList();

          if (pinnedNotes.isEmpty) {
            return const SizedBox();
          }

          return ExpansionTile(
            title: Row(
              children: <Widget>[
                const Icon(Icons.push_pin),
                Text('Pinned', style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            children: <Widget>[
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: pinnedNotes.length,
                itemBuilder: (BuildContext context, int index) {
                  final NoteModel note = pinnedNotes[index];
                  return PinnedCard(note: note, categories: categories);
                },
              ),
            ],
          );
        }

        return const SizedBox();
      },
    );
  }
}
