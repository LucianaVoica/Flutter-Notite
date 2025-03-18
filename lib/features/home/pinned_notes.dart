import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class PinnedNotesCard extends StatelessWidget {
  const PinnedNotesCard({super.key, required this.pinnedNotes});
  final List<String> pinnedNotes;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Color.fromARGB(222, 198, 236, 187),
              AppColors.primaryLight,
            ],
          ),
        ),
        padding: const EdgeInsets.all(16),
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Row(
              children: <Widget>[
                Text(
                  'Pinned',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Spacer(),
                Icon(Icons.push_pin),
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
