import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news/models/category_model.dart';
import 'package:news/models/sport_model.dart';
import 'package:news/repository/sport_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewedProvider extends ChangeNotifier {
  List<int> listViewed = [];
  List<CategoryModel> listCategories = [];
  List<SportModel> listData = [];
  void init() async {
    await getCategories();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? action = prefs.getString('Detail'); // '[1,2]' , null
    listViewed = List<int>.from(jsonDecode(action ?? '[]'));
    notifyListeners();
  }

  Future<void> addViewed(int id) async {
    if (!listViewed.contains(id)) {
      listViewed.add(id);
      print(listViewed);
      notifyListeners();
    } else {
      listViewed.remove(id);
      notifyListeners();
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('Detail', jsonEncode(listViewed));
  }

  void smbmitForm() async {
    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('Detail', jsonEncode(listViewed));
  }

  Future<void> getCategories() async {
    notifyListeners();
  }

  Future<void> getViewedItem() async {
    listData.clear();
    if (listViewed.isEmpty) return;
    for (var id in listViewed) {
      SportModel sport = await SportRepo.getSpostWithId(id);
      listData.add(sport);
    }

    notifyListeners();
  }

  void removeViewed(int id) {
    listData.removeWhere((e) => e.id == id);
    addViewed(id);
    notifyListeners();
  }
}
