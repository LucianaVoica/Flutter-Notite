import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/category_model.dart';
import '../bloc/category_bloc.dart';
import '../bloc/category_event.dart';
import '../bloc/category_state.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

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
                itemCount: state.categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (BuildContext context, int index) {
                  final Category category = state.categories[index];
                  return GestureDetector(
                    onTap: () {
                      context.read<CategoryBloc>().add(
                        SelectCategory(category.id),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color:
                            category.isSelected
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 1.5,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          category.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color:
                                category.isSelected
                                    ? Colors.black
                                    : Colors.black87,
                            fontWeight:
                                category.isSelected
                                    ? FontWeight.bold
                                    : FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
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
