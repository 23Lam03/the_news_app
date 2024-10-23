import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news/models/category_model.dart';
import 'package:news/repository/category_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  List<int> listChooseSeting = [];
  List<int> listSubmitCategories = [];
  bool isLoading = true;

  List<CategoryModel> listCategories = [];

  void init() async {
    await getCategories();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? action = prefs.getString('ChooseSeting'); // '[1,2]' , null
    listChooseSeting = List<int>.from(jsonDecode(action ?? '[]'));
    isLoading = false;
    notifyListeners();
  }

  void initAddList() {
    listSubmitCategories = [...listChooseSeting];
  }

  void handleClickCategory(int id) {
    if (listSubmitCategories.contains(id)) {
      listSubmitCategories.remove(id);
      notifyListeners();
      return;
    }
    listSubmitCategories.add(id);
    notifyListeners();
  }

  void sumbmitForm() async {
    listChooseSeting = [...listSubmitCategories];
    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('ChooseSeting', jsonEncode(listChooseSeting));
  }

  String getName(int id) {
    CategoryModel category = listCategories.firstWhere((e) => e.id == id);
    return category.name;
  }

  Future<List<CategoryModel>> getCategories() async {
    List<CategoryModel> categories = await CategoryRepo.getAllCategories();
    listCategories = categories;
    return categories;
  }
}
