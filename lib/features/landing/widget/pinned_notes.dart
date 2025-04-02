import 'package:flutter/material.dart';

class PinnedNotesCard extends StatelessWidget {
  const PinnedNotesCard({super.key, required this.pinnedNotes});
  final List<String> pinnedNotes;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('Pinned', style: Theme.of(context).textTheme.bodyMedium),

                const Spacer(),
                const Icon(Icons.push_pin),
              ],
            ),
            const SizedBox(height: 12),

            if (pinnedNotes.isEmpty)
              const Center(child: Text('No pinned notes'))
            else
              Expanded(
                child: ListView.builder(
                  itemCount: pinnedNotes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(title: Text(pinnedNotes[index]));
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
