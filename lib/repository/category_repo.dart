import 'package:dio/dio.dart';
import 'package:news/models/category_model.dart';

class CategoryRepo {
  static final dio = Dio();
  static Future<List<CategoryModel>> getAllCategories() async {
    try {
      final response = await dio.get(
          'https://apiforlearning.zendvn.com/api/categories_news?offset=0&limit=10&sort_by=id&sort_dir=asc');
      if (response.statusCode == 200) {
        List data = response.data;
        List<CategoryModel> categories =
            data.map((e) => CategoryModel.fromMap(e)).toList();
        return categories;
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }
}
