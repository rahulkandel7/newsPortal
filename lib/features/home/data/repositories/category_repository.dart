import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sanchar_dainek/core/api/api_error.dart';
import 'package:sanchar_dainek/core/api/dio_exception.dart';
import 'package:sanchar_dainek/features/home/data/data_sources/category_data_sources.dart';
import 'package:sanchar_dainek/features/home/data/models/category.dart';

abstract class CategoryRepository {
  Future<Either<ApiError, List<Category>>> getCategory();
}

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  return CategoryRepositoryImpl(ref.read(categoryDataSourceProvider));
});

class CategoryRepositoryImpl extends CategoryRepository {
  final CategoryDataSource _categoryDataSource;

  CategoryRepositoryImpl(this._categoryDataSource);
  @override
  Future<Either<ApiError, List<Category>>> getCategory() async {
    try {
      final result = await _categoryDataSource.getCategory();
      return Right(result);
    } on DioException catch (e) {
      return Left(ApiError(message: e.message!));
    }
  }
}
