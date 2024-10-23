import 'package:flutter/material.dart';
import 'package:news/models/sport_model.dart';
import 'package:news/repository/search_repo.dart';

class SearchProvider extends ChangeNotifier {
  Future<List<SportModel>> getSearch(String keyword) async {
    List<SportModel> data = await SearchRepo.callSearchApi(keyword);
    return data;
  }
}
