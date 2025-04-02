import 'package:flutter/material.dart';

import '../../data/model/note_model.dart';

class Note extends StatelessWidget {
  const Note({super.key, required this.note});

  final NoteModel note;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Theme.of(context).primaryColor),
        ),
        child: Center(
          child: Text(
            note.title,
            style: Theme.of(
              context,
            ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
