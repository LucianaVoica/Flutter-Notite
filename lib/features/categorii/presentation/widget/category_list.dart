import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/category_model.dart';
import '../bloc/category_bloc.dart';
import '../bloc/category_event.dart';
import '../bloc/category_state.dart';
import 'add_category_form.dart';
import 'category.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

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
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (BuildContext context, CategoryState state) {
        if (state is CategoryLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is CategoryLoaded) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
            child: SizedBox(
              height: 50,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: state.categories.length + 1, // Include butonul „Add”
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    // Butonul "Add" ca primul element
                    return GestureDetector(
                      onTap: () => _showAddCategoryModal(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 1.5,
                          ),
                        ),
                        child: const Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                'Add ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 5),
                              Icon(Icons.add, color: Colors.black),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  final CategoryModel category = state.categories[index - 1];

                  return GestureDetector(
                    onTap: () {
                      context.read<CategoryBloc>().add(
                        SelectCategory(category.id),
                      );
                    },
                    child: Category(category: category),
                  );
                },
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
