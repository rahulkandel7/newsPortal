import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/api_constants.dart';
import 'dio_exception.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

class ApiService {
  getData({required String endpoint}) async {
    final Dio dio = Dio(
      BaseOptions(baseUrl: ApiConstants.url, headers: {
        "accept": "application/json",
      }),
    );
    try {
      final result = await dio.get(endpoint);
      return result.data;
    } on DioError catch (e) {
      throw DioException.fromDioError(e);
    }
  }
}
