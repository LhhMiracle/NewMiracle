/// 天气预报数据模型
class ForecastModel {
  final String date;
  final double maxTemp;
  final double minTemp;
  final String condition;
  final String conditionIcon;
  final int chanceOfRain;
  final double maxWind;

  ForecastModel({
    required this.date,
    required this.maxTemp,
    required this.minTemp,
    required this.condition,
    required this.conditionIcon,
    required this.chanceOfRain,
    required this.maxWind,
  });

  /// 从 JSON 数据创建 ForecastModel 对象
  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    return ForecastModel(
      date: json['date'] ?? '',
      maxTemp: (json['day']['maxtemp_c'] ?? 0).toDouble(),
      minTemp: (json['day']['mintemp_c'] ?? 0).toDouble(),
      condition: json['day']['condition']['text'] ?? '',
      conditionIcon: json['day']['condition']['icon'] ?? '',
      chanceOfRain: json['day']['daily_chance_of_rain'] ?? 0,
      maxWind: (json['day']['maxwind_kph'] ?? 0).toDouble(),
    );
  }

  /// 获取完整的图标 URL
  String get fullIconUrl => 'https:$conditionIcon';

  /// 获取格式化的日期（星期）
  String get weekday {
    final DateTime dateTime = DateTime.parse(date);
    final List<String> weekdays = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
    return weekdays[dateTime.weekday - 1];
  }

  /// 获取简短日期（月/日）
  String get shortDate {
    final DateTime dateTime = DateTime.parse(date);
    return '${dateTime.month}/${dateTime.day}';
  }
}

/// 完整的天气预报响应
class WeatherForecastResponse {
  final String cityName;
  final List<ForecastModel> forecasts;

  WeatherForecastResponse({
    required this.cityName,
    required this.forecasts,
  });

  /// 从 JSON 数据创建 WeatherForecastResponse 对象
  factory WeatherForecastResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> forecastDays = json['forecast']['forecastday'] ?? [];
    final List<ForecastModel> forecasts = forecastDays
        .map((day) => ForecastModel.fromJson(day))
        .toList();

    return WeatherForecastResponse(
      cityName: json['location']['name'] ?? '',
      forecasts: forecasts,
    );
  }
}
