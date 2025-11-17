import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// 通知服务类
/// 负责管理本地通知
class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// 初始化通知服务
  Future<void> initialize() async {
    // Android 初始化设置
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS 初始化设置
    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    // 总初始化设置
    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );
  }

  /// 处理通知点击事件
  void _onNotificationTap(NotificationResponse response) {
    print('通知被点击: ${response.payload}');
    // 可以在这里处理通知点击后的跳转逻辑
  }

  /// 请求通知权限（iOS）
  Future<bool> requestPermissions() async {
    final bool? result = await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    return result ?? false;
  }

  /// 显示即时通知
  /// [title] 通知标题
  /// [body] 通知内容
  /// [payload] 附加数据
  Future<void> showNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'weather_channel',
      '天气通知',
      channelDescription: '天气相关的通知',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notificationsPlugin.show(
      0,
      title,
      body,
      details,
      payload: payload,
    );
  }

  /// 显示天气提醒通知
  /// [cityName] 城市名称
  /// [temperature] 温度
  /// [condition] 天气状况
  Future<void> showWeatherAlert({
    required String cityName,
    required double temperature,
    required String condition,
  }) async {
    await showNotification(
      title: '$cityName 天气提醒',
      body: '当前温度 ${temperature.toInt()}°C，$condition',
      payload: cityName,
    );
  }

  /// 显示极端天气警告
  /// [cityName] 城市名称
  /// [warning] 警告信息
  Future<void> showWeatherWarning({
    required String cityName,
    required String warning,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'weather_warning_channel',
      '天气警告',
      channelDescription: '极端天气警告',
      importance: Importance.max,
      priority: Priority.max,
      showWhen: true,
      color: Color(0xFFF44336),
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notificationsPlugin.show(
      1,
      '⚠️ $cityName 天气警告',
      warning,
      details,
      payload: cityName,
    );
  }

  /// 取消所有通知
  Future<void> cancelAllNotifications() async {
    await _notificationsPlugin.cancelAll();
  }

  /// 取消特定通知
  /// [id] 通知 ID
  Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id);
  }
}
