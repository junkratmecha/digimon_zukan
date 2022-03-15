import 'package:flutter/material.dart';
import '../db/favoritesdigi.dart';

class FavoritesDigiNotifier extends ChangeNotifier {
  final List<FavoriteDigi> _favs = [];

  FavoritesDigiNotifier() {
    syncDb();
  }

  void syncDb() async {
    FavoritesDigiDb.read().then(
          (val) => _favs
        ..clear()
        ..addAll(val),
    );
    notifyListeners();
  }

  List<FavoriteDigi> get favs => _favs;

  void toggle(FavoriteDigi fav) {
    if (isExist(fav.digiId)) {
      delete(fav.digiId);
    } else {
      add(fav);
    }
  }

  bool isExist(int id) {
    if (_favs.indexWhere((fav) => fav.digiId == id) < 0) {
      return false;
    }
    return true;
  }

  void add(FavoriteDigi fav) async {
    await FavoritesDigiDb.create(fav);
    syncDb();
  }

  void delete(int id) async {
    await FavoritesDigiDb.delete(id);
    syncDb();
  }
}

class FavoriteDigi {
  final int digiId;

  FavoriteDigi({
    required this.digiId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': digiId,
    };
  }
}