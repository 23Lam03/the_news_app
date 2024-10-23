import 'package:dio/dio.dart';
import 'package:news/models/sport_model.dart';

class SearchRepo {
  static final dio = Dio();
  static Future<List<SportModel>> callSearchApi(String keyword) async {
    final response = await dio.get(
        'https://apiforlearning.zendvn.com/api/articles/search?q=$keyword&offset=0&limit=10&sort_by=id&sort_dir=desc');
    if (response.statusCode == 200) {
      List data = response.data;
      List<SportModel> sports = data.map((e) => SportModel.fromMap(e)).toList();
      return sports;
    }
    return [];
  }
}
