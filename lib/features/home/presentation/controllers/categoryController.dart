import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sanchar_dainek/features/home/data/models/category.dart';
import 'package:sanchar_dainek/features/home/data/repositories/category_repository.dart';

class CategoryController extends StateNotifier<AsyncValue<List<Category>>> {
  CategoryController(this._categoryRepository) : super(const AsyncLoading()) {
    fetchCategory();
  }
  final CategoryRepository _categoryRepository;
  fetchCategory() async {
    final result = await _categoryRepository.getCategory();
    result.fold(
        (error) => state =
            AsyncError(error.message, StackTrace.fromString(error.toString())),
        (success) => state = AsyncData(success));
  }

  Category findCategory(int id) {
    return state.value!.firstWhere((element) => element.id == id);
  }
}

final categoryControllerProvider =
    StateNotifierProvider<CategoryController, AsyncValue<List<Category>>>(
        (ref) {
  return CategoryController(ref.watch(categoryRepositoryProvider));
});
