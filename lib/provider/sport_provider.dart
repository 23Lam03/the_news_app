import 'package:flutter/material.dart';
import 'package:news/models/sport_model.dart';
import 'package:news/repository/sport_repo.dart';

class SportProvider extends ChangeNotifier {
  final GlobalKey<ScaffoldState> keyHome = GlobalKey();
  final List<SportModel> _sports = [];
  bool isloading = true;

  List<SportModel> get sports => _sports;

  Future<List<SportModel>> fetchSport({id = 1}) async {
    return await SportRepo.getAllSport(id);
  }
}
