import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../theme/app_colors.dart';
import '../../data/model/note_model.dart';
import '../bloc/note_bloc.dart';
import '../bloc/note_state.dart';
import '../widget/note.dart';

class ListaNotite extends StatelessWidget {
  const ListaNotite({super.key, required this.categoryType});

  static MaterialPageRoute<dynamic> route({String categoryType = 'All'}) =>
      MaterialPageRoute<dynamic>(
        builder:
            (BuildContext context) => ListaNotite(categoryType: categoryType),
      );

  final String categoryType;

  @override
  Widget build(BuildContext context) {
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

            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 200,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: state.notes.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (BuildContext context, int index) {
                        final NoteModel note = state.notes[index];
                        return GestureDetector(child: Note(note: note));
                      },
                    ),
                  ),
                ],
              ),
            );
          }

          // În cazul în care starea nu este nici NoteLoading, nici NoteLoaded
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
