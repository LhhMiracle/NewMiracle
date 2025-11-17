import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../models/forecast_model.dart';

/// 温度趋势图表组件
class TemperatureChart extends StatelessWidget {
  final List<ForecastModel> forecasts;

  const TemperatureChart({
    Key? key,
    required this.forecasts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 200,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '7天温度趋势',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: LineChart(
              _createChartData(isDark),
            ),
          ),
        ],
      ),
    );
  }

  LineChartData _createChartData(bool isDark) {
    // 提取最高温和最低温数据
    final List<FlSpot> maxTempSpots = [];
    final List<FlSpot> minTempSpots = [];

    for (int i = 0; i < forecasts.length; i++) {
      maxTempSpots.add(FlSpot(i.toDouble(), forecasts[i].maxTemp));
      minTempSpots.add(FlSpot(i.toDouble(), forecasts[i].minTemp));
    }

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 5,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: isDark ? Colors.white12 : Colors.grey[300]!,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: (value, meta) {
              if (value.toInt() >= forecasts.length) {
                return Text('');
              }
              return Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  forecasts[value.toInt()].shortDate,
                  style: TextStyle(
                    fontSize: 10,
                    color: isDark ? Colors.white70 : Colors.grey[600],
                  ),
                ),
              );
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 10,
            reservedSize: 35,
            getTitlesWidget: (value, meta) {
              return Text(
                '${value.toInt()}°',
                style: TextStyle(
                  fontSize: 10,
                  color: isDark ? Colors.white70 : Colors.grey[600],
                ),
              );
            },
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: (forecasts.length - 1).toDouble(),
      minY: forecasts.map((f) => f.minTemp).reduce((a, b) => a < b ? a : b) - 5,
      maxY: forecasts.map((f) => f.maxTemp).reduce((a, b) => a > b ? a : b) + 5,
      lineBarsData: [
        // 最高温线
        LineChartBarData(
          spots: maxTempSpots,
          isCurved: true,
          color: Colors.orange,
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index) {
              return FlDotCirclePainter(
                radius: 4,
                color: Colors.orange,
                strokeWidth: 2,
                strokeColor: Colors.white,
              );
            },
          ),
          belowBarData: BarAreaData(
            show: true,
            color: Colors.orange.withOpacity(0.1),
          ),
        ),
        // 最低温线
        LineChartBarData(
          spots: minTempSpots,
          isCurved: true,
          color: Colors.blue,
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index) {
              return FlDotCirclePainter(
                radius: 4,
                color: Colors.blue,
                strokeWidth: 2,
                strokeColor: Colors.white,
              );
            },
          ),
          belowBarData: BarAreaData(
            show: true,
            color: Colors.blue.withOpacity(0.1),
          ),
        ),
      ],
    );
  }
}
