import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/services/sqlite_service.dart';

class FavoriteListProvider extends ChangeNotifier {
  final List<Restaurant> _favoriteList = [];
  final SqliteService _service;

  FavoriteListProvider(this._service) {
    loadFavoritesFromDatabase();
  }

  List<Restaurant> get favoriteList => _favoriteList;

  Future<void> loadFavoritesFromDatabase() async {
    final favorites = await _service.getAllItems();
    _favoriteList.clear();
    _favoriteList.addAll(favorites);
    notifyListeners();
  }

  Future<void> addFavorite(Restaurant value) async {
    await _service.insertItem(value);
    _favoriteList.add(value);
    notifyListeners();
  }

  Future<void> removeFavorite(Restaurant value) async {
    await _service.removeItem(value.id);
    _favoriteList.removeWhere((element) => element.id == value.id);
    notifyListeners();
  }

  bool checkItemFavorite(Restaurant value) {
    return _favoriteList.any((element) => element.id == value.id);
  }
}
