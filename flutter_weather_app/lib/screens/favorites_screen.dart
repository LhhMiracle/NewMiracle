import 'package:flutter/material.dart';
import '../services/favorites_service.dart';
import '../services/weather_service.dart';
import '../models/weather_model.dart';

/// 收藏城市页面
class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final FavoritesService _favoritesService = FavoritesService();
  final WeatherService _weatherService = WeatherService();

  List<String> _favoriteCities = [];
  Map<String, WeatherModel?> _weatherData = {};
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    setState(() => _isLoading = true);

    final cities = await _favoritesService.getFavoriteCities();
    setState(() {
      _favoriteCities = cities;
      _isLoading = false;
    });

    // 加载每个城市的天气数据
    for (final city in cities) {
      try {
        final weather = await _weatherService.getWeatherByCity(city);
        if (mounted) {
          setState(() {
            _weatherData[city] = weather;
          });
        }
      } catch (e) {
        print('加载 $city 天气失败: $e');
      }
    }
  }

  Future<void> _removeCity(String cityName) async {
    await _favoritesService.removeFavoriteCity(cityName);
    setState(() {
      _favoriteCities.remove(cityName);
      _weatherData.remove(cityName);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('已从收藏中移除 $cityName')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('收藏城市'),
        actions: [
          if (_favoriteCities.isNotEmpty)
            IconButton(
              icon: Icon(Icons.delete_sweep),
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('清空收藏'),
                    content: Text('确定要清空所有收藏的城市吗？'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: Text('取消'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: Text('确定'),
                      ),
                    ],
                  ),
                );

                if (confirm == true) {
                  await _favoritesService.clearAllFavorites();
                  setState(() {
                    _favoriteCities.clear();
                    _weatherData.clear();
                  });
                }
              },
            ),
        ],
      ),
      body: _buildBody(isDark),
    );
  }

  Widget _buildBody(bool isDark) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (_favoriteCities.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              size: 80,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              '还没有收藏的城市',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '在主页搜索城市后点击收藏按钮',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadFavorites,
      child: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: _favoriteCities.length,
        itemBuilder: (context, index) {
          final cityName = _favoriteCities[index];
          final weather = _weatherData[cityName];

          return _FavoriteCityCard(
            cityName: cityName,
            weather: weather,
            isDark: isDark,
            onRemove: () => _removeCity(cityName),
            onTap: () {
              Navigator.pop(context, cityName);
            },
          );
        },
      ),
    );
  }
}

/// 收藏城市卡片
class _FavoriteCityCard extends StatelessWidget {
  final String cityName;
  final WeatherModel? weather;
  final bool isDark;
  final VoidCallback onRemove;
  final VoidCallback onTap;

  const _FavoriteCityCard({
    Key? key,
    required this.cityName,
    required this.weather,
    required this.isDark,
    required this.onRemove,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              // 天气图标和温度
              if (weather != null) ...[
                Image.network(
                  weather!.fullIconUrl,
                  width: 50,
                  height: 50,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.wb_sunny, size: 50);
                  },
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cityName,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        weather!.condition,
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark ? Colors.white70 : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${weather!.temperature.toInt()}°C',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ] else ...[
                CircularProgressIndicator(strokeWidth: 2),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    cityName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],

              SizedBox(width: 8),

              // 删除按钮
              IconButton(
                icon: Icon(Icons.delete_outline),
                color: Colors.red,
                onPressed: onRemove,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
