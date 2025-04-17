import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../core/widgets/avatar.dart';
import '../../categories/data/models/category_model.dart';
import '../../categories/presentation/bloc/category_bloc.dart';
import '../../categories/presentation/bloc/category_event.dart';
import '../../categories/presentation/bloc/category_state.dart';
import '../../categories/presentation/pages/category_list.dart';
import '../../categories/presentation/widget/add_category_form.dart';
import '../../notite/presentation/bloc/note_bloc.dart';
import '../../notite/presentation/bloc/note_event.dart';
import '../../notite/presentation/widget/add_note_form.dart';
import '../widget/photo_card.dart';
import '../widget/search_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String route = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(
      LoadCategories(categories: const <CategoryModel>[]),
    );
    context.read<NoteBloc>().add(LoadPinnedNotes());
  }

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

  void _navigateToAddNote() {
    final CategoryState state = context.read<CategoryBloc>().state;
    if (state is CategoryLoaded) {
      Navigator.push(
        context,
        MaterialPageRoute<dynamic>(
          builder:
              (BuildContext context) =>
                  Scaffold(body: AddNoteForm(categories: state.categories)),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Se încarcă categoriile...')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double halfScreenHeight = MediaQuery.of(context).size.height * 0.25;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 246, 246),
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: const SearchCard(),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.folder, size: 28, color: Colors.white),
            onPressed: () => _showAddCategoryModal(context),
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 2),
          const Avatar(),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const PhotoCard(),
              const CategoryList(),

              // Craduri de facut
              StaggeredGrid.count(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: <Widget>[
                  SizedBox(
                    height: halfScreenHeight,
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'TODO List',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text('✔ Cumpără lapte'),
                            Text('✔ Trimite email'),
                            Text('❌ Fă backup'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: halfScreenHeight,
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Starea zilei',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text('😊 Astăzi te simți bine!'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // 🔹 Lista de notițe pin
              // BlocBuilder<CategoryBloc, CategoryState>(
              //   builder: (BuildContext context, CategoryState state) {
              //     if (state is CategoryLoaded) {
              //       return NotesPinList(categories: state.categories);
              //     } else {
              //       return const Center(child: CircularProgressIndicator());
              //     }
              //   },
              // ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddNote,
        backgroundColor: Colors.black,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 30, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
