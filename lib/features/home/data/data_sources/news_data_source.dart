import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sanchar_dainek/core/api/api_service.dart';
import 'package:sanchar_dainek/features/home/data/models/news.dart';

abstract class NewsDataSource {
  Future<List<News>> getNews();
}

final newsDataSourceProvider = Provider<NewsDataSource>((ref) {
  return NewsDataSourceImpl(ref.read(apiServiceProvider));
});

class NewsDataSourceImpl extends NewsDataSource {
  final ApiService _apiService;

  NewsDataSourceImpl(this._apiService);
  @override
  Future<List<News>> getNews() async {
    final result = await _apiService.getData(endpoint: 'news');
    final news = result as List<dynamic>;
    return news.map((newss) => News.fromMap(newss)).toList();
  }
}
