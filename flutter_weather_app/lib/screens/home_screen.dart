import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/weather_model.dart';
import '../models/forecast_model.dart';
import '../services/weather_service.dart';
import '../services/location_service.dart';
import '../services/favorites_service.dart';
import '../services/notification_service.dart';
import '../providers/theme_provider.dart';
import '../widgets/weather_display.dart';
import '../widgets/forecast_list.dart';
import '../widgets/temperature_chart.dart';
import 'favorites_screen.dart';

/// 主页面 - 天气查询界面（完整版）
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _cityController = TextEditingController();
  final WeatherService _weatherService = WeatherService();
  final LocationService _locationService = LocationService();
  final FavoritesService _favoritesService = FavoritesService();
  final NotificationService _notificationService = NotificationService();

  WeatherModel? _weather;
  WeatherForecastResponse? _forecast;
  bool _isLoading = false;
  bool _isFavorite = false;
  String? _errorMessage;
  String? _currentCity;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _cityController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  /// 搜索天气
  Future<void> _searchWeather() async {
    final cityName = _cityController.text.trim();
    if (cityName.isEmpty) {
      setState(() => _errorMessage = '请输入城市名称');
      return;
    }

    await _loadWeatherData(cityName);
  }

  /// 使用定位获取天气
  Future<void> _getWeatherByLocation() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _weather = null;
      _forecast = null;
    });

    try {
      final coords = await _locationService.getCurrentCoordinates();
      if (coords == null) {
        throw Exception('无法获取位置信息');
      }

      final weather = await _weatherService.getWeatherByCoordinates(
        coords['latitude']!,
        coords['longitude']!,
      );

      final forecast = await _weatherService.getForecastByCoordinates(
        coords['latitude']!,
        coords['longitude']!,
      );

      setState(() {
        _weather = weather;
        _forecast = forecast;
        _currentCity = weather.cityName;
        _cityController.text = weather.cityName;
        _isLoading = false;
      });

      await _checkFavoriteStatus();

      // 发送通知
      await _notificationService.showWeatherAlert(
        cityName: weather.cityName,
        temperature: weather.temperature,
        condition: weather.condition,
      );
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceAll('Exception: ', '');
        _isLoading = false;
      });
    }
  }

  /// 加载天气数据
  Future<void> _loadWeatherData(String cityName) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _weather = null;
      _forecast = null;
    });

    try {
      final weather = await _weatherService.getWeatherByCity(cityName);
      final forecast = await _weatherService.getForecastByCity(cityName);

      setState(() {
        _weather = weather;
        _forecast = forecast;
        _currentCity = cityName;
        _isLoading = false;
      });

      await _checkFavoriteStatus();

      // 发送通知
      await _notificationService.showWeatherAlert(
        cityName: weather.cityName,
        temperature: weather.temperature,
        condition: weather.condition,
      );
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceAll('Exception: ', '');
        _isLoading = false;
      });
    }
  }

  /// 检查收藏状态
  Future<void> _checkFavoriteStatus() async {
    if (_currentCity != null) {
      final isFav = await _favoritesService.isFavorite(_currentCity!);
      setState(() => _isFavorite = isFav);
    }
  }

  /// 切换收藏状态
  Future<void> _toggleFavorite() async {
    if (_currentCity == null) return;

    if (_isFavorite) {
      await _favoritesService.removeFavoriteCity(_currentCity!);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('已从收藏中移除 $_currentCity')),
      );
    } else {
      await _favoritesService.addFavoriteCity(_currentCity!);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('已收藏 $_currentCity')),
      );
    }

    setState(() => _isFavorite = !_isFavorite);
  }

  /// 打开收藏页面
  Future<void> _openFavorites() async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => FavoritesScreen()),
    );

    if (result != null) {
      _cityController.text = result;
      await _loadWeatherData(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      body: Container(
        decoration: !isDark
            ? BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blue.shade400, Colors.purple.shade300],
                ),
              )
            : null,
        child: SafeArea(
          child: Column(
            children: [
              // 顶部工具栏
              _buildAppBar(themeProvider),

              // 搜索栏
              _buildSearchBar(),

              SizedBox(height: 20),

              // 内容区域
              Expanded(child: _buildContent()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(ThemeProvider themeProvider) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Text(
            '天气',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: themeProvider.isDarkMode ? Colors.white : Colors.white,
            ),
          ),
          Spacer(),
          // 收藏按钮
          IconButton(
            icon: Icon(Icons.favorite_border),
            color: themeProvider.isDarkMode ? Colors.white : Colors.white,
            onPressed: _openFavorites,
          ),
          // 主题切换按钮
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            color: themeProvider.isDarkMode ? Colors.white : Colors.white,
            onPressed: () => themeProvider.toggleTheme(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // 定位按钮
          Container(
            decoration: BoxDecoration(
              color: Colors.blue.shade600,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.my_location, color: Colors.white),
              onPressed: _getWeatherByLocation,
            ),
          ),
          SizedBox(width: 12),

          // 搜索框
          Expanded(
            child: TextField(
              controller: _cityController,
              style: TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                hintText: '输入城市名称',
                hintStyle: TextStyle(color: Colors.grey.shade600),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                suffixIcon: _currentCity != null
                    ? IconButton(
                        icon: Icon(
                          _isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: _isFavorite ? Colors.red : Colors.grey,
                        ),
                        onPressed: _toggleFavorite,
                      )
                    : null,
              ),
              onSubmitted: (_) => _searchWeather(),
            ),
          ),
          SizedBox(width: 12),

          // 搜索按钮
          Container(
            decoration: BoxDecoration(
              color: Colors.blue.shade600,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: _searchWeather,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.white),
            SizedBox(height: 16),
            Text('加载中...', style: TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 80, color: Colors.white),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      );
    }

    if (_weather != null && _forecast != null) {
      return Column(
        children: [
          // Tab 切换
          TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: '当前天气'),
              Tab(text: '7天预报'),
            ],
          ),

          // Tab 内容
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // 当前天气
                WeatherDisplay(weather: _weather!),

                // 7天预报
                SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TemperatureChart(forecasts: _forecast!.forecasts),
                      SizedBox(height: 16),
                      ForecastList(forecasts: _forecast!.forecasts),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    // 默认状态
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.wb_sunny_outlined, size: 100, color: Colors.white),
          SizedBox(height: 24),
          Text(
            '请输入城市名称查询天气',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 8),
          Text(
            '或点击定位图标获取当前位置天气',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
