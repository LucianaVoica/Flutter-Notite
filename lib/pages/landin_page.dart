import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../features/categorii/presentation/widget/add_category_form.dart';
import '../features/categorii/presentation/widget/category_list.dart';
import '../features/home/pinned_notes.dart';
import '../theme/app_colors.dart';
import '../theme/gradient.dart';
import '../widget/avatar/avatar.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});
  static const String route = '/';

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  void _showAddCategoryModal(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: 250,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 16,
              right: 16,
              top: 16,
            ),
            child: const AddCategoryForm(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: AppColors.secondaryLight,
        title: const Text(
          'My Notes ',
          style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          Text('Hi, Luci ', style: Theme.of(context).textTheme.titleSmall),
          const Avatar(),
        ],
      ),
      body: GradientBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const CategoryList(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SfCalendar(
                headerStyle: const CalendarHeaderStyle(
                  backgroundColor: AppColors.primaryLight,
                ),
                view: CalendarView.month,
              ),
            ),
            const PinnedNotesCard(
              pinnedNotes: <String>[
                'Note 1',
                'Important Note',
                'Remember this',
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: IconButton(
                icon: const Icon(Icons.folder, size: 50),
                onPressed: () => _showAddCategoryModal(context),
                color: AppColors.primaryLight,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddCategoryModal,
        backgroundColor: Theme.of(context).primaryColor,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 30, color: Colors.black),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
