import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../theme/app_colors.dart';
import '../../data/model/note_model.dart';
import '../bloc/note_bloc.dart';
import '../bloc/note_event.dart';
import '../bloc/note_state.dart';
import '../widget/note.dart';

class ListaNotite extends StatelessWidget {
  const ListaNotite({super.key, required this.categoryType});

  static MaterialPageRoute<dynamic> route({
    String categoryType = '00000000-0000-0000-0000-000000000001',
  }) => MaterialPageRoute<dynamic>(
    builder: (BuildContext context) => ListaNotite(categoryType: categoryType),
  );

  final String categoryType;

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
                return Note(note: note);
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
