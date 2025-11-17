import 'package:shared_preferences/shared_preferences.dart';

/// 收藏城市服务类
/// 使用 SharedPreferences 本地存储收藏的城市列表
class FavoritesService {
  static const String _favoritesKey = 'favorite_cities';

  /// 获取收藏的城市列表
  Future<List<String>> getFavoriteCities() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String>? cities = prefs.getStringList(_favoritesKey);
      return cities ?? [];
    } catch (e) {
      print('获取收藏城市失败: $e');
      return [];
    }
  }

  /// 添加城市到收藏
  /// [cityName] 城市名称
  /// 返回 true 表示添加成功，false 表示已存在
  Future<bool> addFavoriteCity(String cityName) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String> cities = await getFavoriteCities();

      // 检查是否已存在
      if (cities.contains(cityName)) {
        return false;
      }

      // 添加到列表
      cities.add(cityName);
      await prefs.setStringList(_favoritesKey, cities);
      return true;
    } catch (e) {
      print('添加收藏城市失败: $e');
      return false;
    }
  }

  /// 从收藏中移除城市
  /// [cityName] 城市名称
  /// 返回 true 表示移除成功
  Future<bool> removeFavoriteCity(String cityName) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String> cities = await getFavoriteCities();

      // 移除城市
      cities.remove(cityName);
      await prefs.setStringList(_favoritesKey, cities);
      return true;
    } catch (e) {
      print('移除收藏城市失败: $e');
      return false;
    }
  }

  /// 检查城市是否已收藏
  /// [cityName] 城市名称
  /// 返回 true 表示已收藏
  Future<bool> isFavorite(String cityName) async {
    try {
      final List<String> cities = await getFavoriteCities();
      return cities.contains(cityName);
    } catch (e) {
      print('检查收藏状态失败: $e');
      return false;
    }
  }

  /// 清空所有收藏
  Future<void> clearAllFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_favoritesKey);
    } catch (e) {
      print('清空收藏失败: $e');
    }
  }

  /// 获取收藏数量
  Future<int> getFavoritesCount() async {
    final cities = await getFavoriteCities();
    return cities.length;
  }
}
