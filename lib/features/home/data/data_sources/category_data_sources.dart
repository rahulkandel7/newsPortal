import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sanchar_dainek/core/api/api_service.dart';

import '../models/category.dart';

abstract class CategoryDataSource {
  Future<List<Category>> getCategory();
}

final categoryDataSourceProvider = Provider<CategoryDataSource>((ref) {
  return CategoryDataSourceImpl(ref.read(apiServiceProvider));
});

class CategoryDataSourceImpl extends CategoryDataSource {
  final ApiService _apiService;
  CategoryDataSourceImpl(this._apiService);

  @override
  Future<List<Category>> getCategory() async {
    final result = await _apiService.getData(endpoint: 'category');
    final categories = result as List<dynamic>;

    return categories.map((category) => Category.fromMap(category)).toList();
  }
}
