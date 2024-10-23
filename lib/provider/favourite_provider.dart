import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news/models/category_model.dart';
import 'package:news/models/sport_model.dart';
import 'package:news/repository/sport_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteProvider extends ChangeNotifier {
  List<int> listFavourite = [];
  List<CategoryModel> listCategories = [];
  List<SportModel> listData = [];
  void init() async {
    await getCategories();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? action = prefs.getString('Favourite'); // '[1,2]' , null
    listFavourite = List<int>.from(jsonDecode(action ?? '[]'));
    notifyListeners();
  }

  Future<void> addFavourite(int id) async {
    if (!listFavourite.contains(id)) {
      listFavourite.add(id);
      notifyListeners();
    } else {
      listFavourite.remove(id);
      notifyListeners();
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('Favourite', jsonEncode(listFavourite));
  }

  void sumbmitForm() async {
    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('Favourite', jsonEncode(listFavourite));
  }

  Future<void> getCategories() async {
    notifyListeners();
  }

  Future<void> getFavouriteItem() async {
    listData.clear();
    if (listFavourite.isEmpty) return;
    for (var id in listFavourite) {
      SportModel sport = await SportRepo.getSpostWithId(id);
      listData.add(sport);
    }
    notifyListeners();
  }

  void removeFavoute(int id) {
    listData.removeWhere((e) => e.id == id);
    addFavourite(id);
    notifyListeners();
  }
}
