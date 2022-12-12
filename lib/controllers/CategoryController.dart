import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/category.dart';
import 'package:http/http.dart' as http;

class CategoryController extends StateNotifier<List<Category>> {
  CategoryController(List<Category> state) : super(state);

  fetchCategory() async {
    var url = Uri.parse("https://www.samacharsadhai.com/api/test/category");

    try {
      final response = await http.get(url);

      final extractData = json.decode(response.body) as List;

      for (var element in extractData) {
        state.add(
          Category(
            id: element['id'],
            name: element['categoryname'],
          ),
        );
      }
    } catch (error) {
      rethrow;
    }
  }
}

final categoryProvider =
    StateNotifierProvider<CategoryController, List<Category>>((ref) {
  return CategoryController([]);
});
