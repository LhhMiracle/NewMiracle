import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

/// 天气 API 服务类
/// 负责与 WeatherAPI.com 进行通信
class WeatherService {
  // 请替换为你自己的 API Key
  // 可以在 https://www.weatherapi.com/ 免费注册获取
  static const String _apiKey = 'YOUR_API_KEY_HERE';
  static const String _baseUrl = 'https://api.weatherapi.com/v1';

  /// 根据城市名称获取天气信息
  ///
  /// [cityName] 城市名称（支持中文）
  /// 返回 WeatherModel 对象，如果失败则抛出异常
  Future<WeatherModel> getWeatherByCity(String cityName) async {
    try {
      final url = Uri.parse(
        '$_baseUrl/current.json?key=$_apiKey&q=$cityName&aqi=no',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return WeatherModel.fromJson(data);
      } else if (response.statusCode == 400) {
        throw Exception('无法找到该城市，请检查城市名称是否正确');
      } else if (response.statusCode == 401) {
        throw Exception('API Key 无效，请检查配置');
      } else if (response.statusCode == 403) {
        throw Exception('API Key 已超出配额限制');
      } else {
        throw Exception('获取天气信息失败: ${response.statusCode}');
      }
    } catch (e) {
      if (e is Exception) {
        rethrow;
      }
      throw Exception('网络请求失败: $e');
    }
  }

  /// 根据经纬度获取天气信息
  ///
  /// [latitude] 纬度
  /// [longitude] 经度
  /// 返回 WeatherModel 对象，如果失败则抛出异常
  Future<WeatherModel> getWeatherByCoordinates(
    double latitude,
    double longitude,
  ) async {
    try {
      final url = Uri.parse(
        '$_baseUrl/current.json?key=$_apiKey&q=$latitude,$longitude&aqi=no',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return WeatherModel.fromJson(data);
      } else {
        throw Exception('获取天气信息失败: ${response.statusCode}');
      }
    } catch (e) {
      if (e is Exception) {
        rethrow;
      }
      throw Exception('网络请求失败: $e');
    }
  }
}
