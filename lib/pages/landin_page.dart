import 'package:flutter/material.dart';
import '../features/categorii/presentation/widget/add_category_form.dart';
import '../features/categorii/presentation/widget/category_list.dart';
import '../features/home/calendar.dart';
import '../features/home/pinned_notes.dart';
import '../theme/app_colors.dart';
import '../theme/gradient.dart';
import '../widget/avatar/avatar.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key, required this.appTitle});
  static const String route = '/';

  final String appTitle;

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
        title: Row(
          children: <Widget>[
            const Avatar(),
            Text('Hi, Luci', style: Theme.of(context).textTheme.titleSmall),
          ],
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.add, size: 30),
                onPressed: () => _showAddCategoryModal(context),
                color: Colors.black,
              ),
            ],
          ),
        ],
      ),
      body: const GradientBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'My',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Notes',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            CategoryList(),
            CalendarCard(),
            PinnedNotesCard(
              pinnedNotes: <String>[
                'Note 1',
                'Important Note',
                'Remember this',
              ],
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   backgroundColor: Theme.of(context).primaryColor,
      //   shape: const CircleBorder(),
      //   child: const Icon(Icons.add, size: 30, color: Colors.black),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
