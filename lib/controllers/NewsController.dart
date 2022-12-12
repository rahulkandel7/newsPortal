import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../models/news.dart';

class NewsController extends StateNotifier<List<News>> {
  NewsController(List<News> state) : super(state);

  fetchNews() async {
    var url = Uri.parse("https://www.samacharsadhai.com/api/test/news");

    try {
      final response = await http.get(url);

      final extractData = json.decode(response.body) as List;

      for (var element in extractData) {
        state.insert(
          0,
          News(
            id: element['id'],
            news_heading: element['news_heading'],
            news_content: element['news_content'],
            photopath: element['photopath'],
            news_date: element['news_date'],
            category_id: int.parse(element['category_id']),
            views: int.parse(element['views']),
          ),
        );
      }
    } catch (error) {
      rethrow;
    }
  }

  // getCategoryName(int id) {
  //   final categoryController = Get.put(CategoryController());
  //   final category = categoryController.category;
  //   var cname = category.firstWhere((element) => element.id == id);
  //   return cname.name;
  // }

  // getCategoryID(String name) {
  //   final categoryController = Get.put(CategoryController());
  //   final category = categoryController.category;
  //   var cid = category.firstWhere((element) => element.name == name);
  //   return cid.id;
  // }

  News findNews(int id) {
    return state.firstWhere((element) => element.id == id);
  }
}

final newsProvider = StateNotifierProvider<NewsController, List<News>>((ref) {
  return NewsController([]);
});
