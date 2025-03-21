import '../data/category_model.dart';

abstract class ICategoryRepository {
  Future<List<CategoryModel>> getCategories();
  Future<void> addCategory(CategoryModel category);
  Future<void> selectCategory(String categoryId);
}
