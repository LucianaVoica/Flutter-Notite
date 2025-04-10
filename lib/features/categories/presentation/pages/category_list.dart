import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/loader.dart';
import '../../../notite/presentation/pages/notes_list.dart';
import '../../data/models/category_model.dart';
import '../bloc/category_bloc.dart';
import '../bloc/category_event.dart';
import '../bloc/category_state.dart';
import '../widget/category.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (BuildContext context, CategoryState state) {
        if (state is CategoryLoading) {
          return const Loader();
        }

        if (state is CategoryLoaded) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 50,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemCount: state.categories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (BuildContext context, int index) {
                      final CategoryModel category = state.categories[index];

                      return CategoryCard(
                        category: category,
                        onTap: () {
                          Navigator.push(
                            context,
                            ListaNotite.route(
                              categoryType: category.id,
                              categories: state.categories,
                            ),
                          );
                        },
                        onDelete:
                            index < 3
                                ? null
                                : () {
                                  context.read<CategoryBloc>().add(
                                    DeleteCategory(category: category),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Categoria "${category.name}" a fost ștearsă.',
                                      ),
                                    ),
                                  );
                                },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
