import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sanchar_dainek/features/home/data/models/news.dart';
import 'package:sanchar_dainek/features/home/data/repositories/news_repository.dart';

class NewsController extends StateNotifier<AsyncValue<List<News>>> {
  NewsController(this._newsRepository) : super(const AsyncLoading()) {
    fetchNews();
  }
  final NewsRepository _newsRepository;
  fetchNews() async {
    final result = await _newsRepository.getNews();
    result.fold(
        (error) => state =
            AsyncError(error.message, StackTrace.fromString(error.toString())),
        (success) => state = AsyncData(success));
  }

  News findNews(int id) {
    return state.value!.firstWhere((element) => element.id == id);
  }
}

final newsControllerProvider =
    StateNotifierProvider<NewsController, AsyncValue<List<News>>>((ref) {
  return NewsController(ref.watch(newsRepositoryProvider));
});
