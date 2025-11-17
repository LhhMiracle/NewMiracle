/// 天气数据模型
/// 用于存储从 API 获取的天气信息
class WeatherModel {
  final String cityName;
  final String region;
  final String country;
  final double temperature;
  final double feelsLike;
  final String condition;
  final String conditionIcon;
  final int humidity;
  final double windSpeed;
  final double uvIndex;
  final String localTime;

  WeatherModel({
    required this.cityName,
    required this.region,
    required this.country,
    required this.temperature,
    required this.feelsLike,
    required this.condition,
    required this.conditionIcon,
    required this.humidity,
    required this.windSpeed,
    required this.uvIndex,
    required this.localTime,
  });

  /// 从 JSON 数据创建 WeatherModel 对象
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['location']['name'] ?? '',
      region: json['location']['region'] ?? '',
      country: json['location']['country'] ?? '',
      temperature: (json['current']['temp_c'] ?? 0).toDouble(),
      feelsLike: (json['current']['feelslike_c'] ?? 0).toDouble(),
      condition: json['current']['condition']['text'] ?? '',
      conditionIcon: json['current']['condition']['icon'] ?? '',
      humidity: json['current']['humidity'] ?? 0,
      windSpeed: (json['current']['wind_kph'] ?? 0).toDouble(),
      uvIndex: (json['current']['uv'] ?? 0).toDouble(),
      localTime: json['location']['localtime'] ?? '',
    );
  }

  /// 转换为华氏温度
  double get temperatureFahrenheit => (temperature * 9 / 5) + 32;

  /// 转换为华氏体感温度
  double get feelsLikeFahrenheit => (feelsLike * 9 / 5) + 32;

  /// 获取完整的图标 URL
  String get fullIconUrl => 'https:$conditionIcon';
}
