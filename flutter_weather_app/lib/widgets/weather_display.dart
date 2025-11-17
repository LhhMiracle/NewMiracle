import 'package:flutter/material.dart';
import '../models/weather_model.dart';

/// 天气信息显示组件
class WeatherDisplay extends StatelessWidget {
  final WeatherModel weather;

  const WeatherDisplay({
    Key? key,
    required this.weather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // 城市信息
          _buildCityInfo(),
          SizedBox(height: 20),

          // 温度和天气状况
          _buildTemperatureInfo(),
          SizedBox(height: 30),

          // 详细信息卡片
          _buildDetailsCards(),
          SizedBox(height: 20),

          // 更新时间
          _buildUpdateTime(),
        ],
      ),
    );
  }

  /// 城市信息
  Widget _buildCityInfo() {
    return Column(
      children: [
        Text(
          weather.cityName,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4),
        Text(
          '${weather.region}, ${weather.country}',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  /// 温度和天气状况
  Widget _buildTemperatureInfo() {
    return Column(
      children: [
        // 天气图标
        if (weather.conditionIcon.isNotEmpty)
          Image.network(
            weather.fullIconUrl,
            width: 100,
            height: 100,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.wb_sunny,
                size: 100,
                color: Colors.white,
              );
            },
          ),
        SizedBox(height: 10),

        // 温度
        Text(
          '${weather.temperature.toInt()}°C',
          style: TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
        ),

        // 天气状况
        Text(
          weather.condition,
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),

        // 体感温度
        Text(
          '体感温度 ${weather.feelsLike.toInt()}°C',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  /// 详细信息卡片
  Widget _buildDetailsCards() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _WeatherDetailCard(
                icon: Icons.water_drop,
                title: '湿度',
                value: '${weather.humidity}%',
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _WeatherDetailCard(
                icon: Icons.air,
                title: '风速',
                value: '${weather.windSpeed.toStringAsFixed(1)} km/h',
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _WeatherDetailCard(
                icon: Icons.wb_sunny,
                title: '紫外线指数',
                value: weather.uvIndex.toInt().toString(),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _WeatherDetailCard(
                icon: Icons.thermostat,
                title: '华氏温度',
                value: '${weather.temperatureFahrenheit.toInt()}°F',
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// 更新时间
  Widget _buildUpdateTime() {
    return Text(
      '更新时间: ${weather.localTime}',
      style: TextStyle(
        fontSize: 12,
        color: Colors.white60,
      ),
    );
  }
}

/// 天气详细信息卡片
class _WeatherDetailCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _WeatherDetailCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 36,
            color: Colors.white,
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white70,
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
