import 'package:dio/dio.dart';
import 'package:news/models/sport_model.dart';

class SportRepo {
  static final dio = Dio();
  static Future<List<SportModel>> getAllSport(id) async {
    final response = await dio.get(
        'https://apiforlearning.zendvn.com/api/categories_news/$id/articles?offset=0&limit=10&sort_by=id&sort_dir=desc');
    if (response.statusCode == 200) {
      List data = response.data;
      List<SportModel> sports = data.map((e) => SportModel.fromMap(e)).toList();
      return sports;
    }
    return [];
  }

  static Future<SportModel> getSpostWithId(int id) async {
    final response =
        await dio.get('https://apiforlearning.zendvn.com/api/articles/$id');
    if (response.statusCode == 200) {
      final data = response.data;
      SportModel sport = SportModel.fromMap(data);
      return sport;
    }
    throw Error();
  }
}
