import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sanchar_dainek/core/api/api_error.dart';
import 'package:sanchar_dainek/core/api/dio_exception.dart';
import 'package:sanchar_dainek/features/home/data/data_sources/news_data_source.dart';
import 'package:sanchar_dainek/features/home/data/models/news.dart';

abstract class NewsRepository {
  Future<Either<ApiError, List<News>>> getNews();
}

final newsRepositoryProvider = Provider<NewsRepository>((ref) {
  return NewsRepositoryImpl(ref.read(newsDataSourceProvider));
});

class NewsRepositoryImpl extends NewsRepository {
  final NewsDataSource _newsDataSource;

  NewsRepositoryImpl(this._newsDataSource);
  @override
  Future<Either<ApiError, List<News>>> getNews() async {
    try {
      final result = await _newsDataSource.getNews();
      return Right(result);
    } on DioException catch (e) {
      return Left(ApiError(message: e.message!));
    }
  }
}
