import 'package:get_it/get_it.dart';
import '../../features/categories/domain/category_repository_impl.dart';
import '../../features/categories/domain/icategory_repository.dart';
import '../../features/notite/domain/inote_repository.dart';
import '../../features/notite/domain/note_repository_impl.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<ICategoryRepository>(
    () => CategoryRepositoryImpl(),
  );
  locator.registerLazySingleton<INoteRepository>(() => NoteRepositoryImpl());
}
