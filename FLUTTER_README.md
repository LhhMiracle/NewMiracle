# Flutter Weather App V2.0 - 完整功能版

一个功能完整的跨平台天气应用，使用 Flutter 和 Dart 开发，支持 iOS、Android、Web、Windows、macOS 和 Linux。

## ✨ 功能特性

### 核心功能
- ✅ **实时天气查询** - 支持城市名称搜索（中文/英文）
- ✅ **定位功能** - 自动获取当前位置天气
- ✅ **7天天气预报** - 完整的未来一周天气信息
- ✅ **收藏城市** - 本地保存常用城市列表
- ✅ **深色模式** - 自动适配系统主题或手动切换
- ✅ **温度趋势图表** - 可视化展示温度变化
- ✅ **天气提醒通知** - 本地推送天气更新
- ✅ **跨平台支持** - iOS、Android、Web、Desktop

### 数据展示
- 当前温度（摄氏度/华氏度）
- 天气状况描述
- 体感温度
- 湿度百分比
- 风速（km/h）
- 紫外线指数
- 降雨概率
- 最高/最低温度

## 📱 界面预览

### 主界面功能
- 🔍 智能搜索框（带收藏按钮）
- 📍 一键定位获取天气
- 🌙 深色/浅色主题切换
- ⭐ 收藏城市快速访问
- 📊 温度趋势图表
- 📅 7天详细预报

## 🚀 快速开始

### 前置要求

1. **Flutter SDK 3.0+**
   ```bash
   flutter --version
   ```

2. **开发工具**（任选其一）
   - VS Code + Flutter 插件
   - Android Studio + Flutter 插件

### 安装步骤

#### 1. 克隆项目

```bash
git clone https://github.com/LhhMiracle/NewMiracle.git
cd NewMiracle
git checkout claude/analyze-repo-structure-01HYZwPf1MdkqndmoADAnkEa
cd flutter_weather_app
```

#### 2. 安装依赖

```bash
flutter pub get
```

#### 3. 获取 API Key

1. 访问 [WeatherAPI.com](https://www.weatherapi.com/)
2. 免费注册并获取 API Key

#### 4. 配置 API Key

打开 `lib/services/weather_service.dart`，替换第 10 行：

```dart
static const String _apiKey = '你的API_KEY';
```

#### 5. 运行应用

```bash
# Web（最简单）
flutter run -d chrome

# Android
flutter run -d android

# iOS（需要 macOS）
flutter run -d ios

# Windows/macOS/Linux
flutter run -d windows
flutter run -d macos
flutter run -d linux
```

## 📦 项目结构

```
flutter_weather_app/
├── lib/
│   ├── main.dart                          # 应用入口 + Provider配置
│   ├── models/                            # 数据模型
│   │   ├── weather_model.dart             # 当前天气模型
│   │   └── forecast_model.dart            # 预报数据模型
│   ├── services/                          # 业务服务层
│   │   ├── weather_service.dart           # 天气 API 服务
│   │   ├── location_service.dart          # 定位服务
│   │   ├── favorites_service.dart         # 收藏管理
│   │   └── notification_service.dart      # 通知服务
│   ├── providers/                         # 状态管理
│   │   └── theme_provider.dart            # 主题管理
│   ├── screens/                           # 页面
│   │   ├── home_screen.dart               # 主页面
│   │   └── favorites_screen.dart          # 收藏页面
│   └── widgets/                           # UI 组件
│       ├── weather_display.dart           # 天气展示组件
│       ├── forecast_list.dart             # 预报列表
│       └── temperature_chart.dart         # 温度图表
├── pubspec.yaml                           # 项目配置
└── README.md                              # 文档
```

## 🎯 使用指南

### 搜索天气
1. 在搜索框输入城市名称（如"北京"、"Shanghai"、"Tokyo"）
2. 点击搜索按钮或按回车键
3. 查看当前天气和7天预报

### 使用定位
1. 点击左侧的定位图标📍
2. 授予位置权限
3. 自动显示当前位置天气

### 收藏城市
1. 搜索城市后，点击搜索框右侧的❤️图标
2. 点击顶部的收藏按钮查看所有收藏
3. 在收藏列表中点击城市快速查看天气

### 切换主题
1. 点击顶部的🌙/☀️图标
2. 在深色和浅色模式间切换
3. 设置会自动保存

### 查看预报
1. 搜索城市后，切换到"7天预报"标签
2. 查看温度趋势图表
3. 浏览详细的每日预报信息

## 📚 技术栈

| 技术 | 版本 | 用途 |
|------|------|------|
| Flutter | 3.x | UI 框架 |
| Dart | 2.17+ | 编程语言 |
| Provider | ^6.1.1 | 状态管理 |
| http | ^1.1.0 | 网络请求 |
| geolocator | ^10.1.0 | 定位服务 |
| shared_preferences | ^2.2.2 | 本地存储 |
| fl_chart | ^0.65.0 | 图表展示 |
| flutter_local_notifications | ^16.2.0 | 本地通知 |
| permission_handler | ^11.0.1 | 权限管理 |
| intl | ^0.18.1 | 日期格式化 |

## 🔧 高级配置

### Android 权限配置

在 `android/app/src/main/AndroidManifest.xml` 中添加：

```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
```

### iOS 权限配置

在 `ios/Runner/Info.plist` 中添加：

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>需要访问您的位置以获取当地天气信息</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>需要访问您的位置以提供天气服务</string>
```

## 🐛 常见问题

### Q1: 无法获取定位

**解决方案**:
1. 确保已授予位置权限
2. 检查设备的定位服务是否开启
3. 在设置中手动开启应用的位置权限

### Q2: 通知不显示

**解决方案**:
- **Android**: 检查应用通知权限
- **iOS**: 在首次运行时授予通知权限

### Q3: 图表不显示

**解决方案**:
```bash
flutter clean
flutter pub get
flutter run
```

### Q4: API 调用失败

**检查**:
- ✅ API Key 是否正确
- ✅ 网络连接是否正常
- ✅ API 配额是否用完（免费版每天100万次调用）

## 📊 性能优化

项目已实现的优化：
- ✅ 使用 `const` 构造函数减少重建
- ✅ 图片网络缓存
- ✅ 异步数据加载
- ✅ Provider 状态管理
- ✅ ListView 懒加载

## 🎨 自定义主题

### 修改浅色主题

编辑 `lib/providers/theme_provider.dart` 中的 `getLightTheme()` 方法：

```dart
static ThemeData getLightTheme() {
  return ThemeData(
    primarySwatch: Colors.blue, // 修改主色调
    // ... 其他配置
  );
}
```

### 修改深色主题

编辑 `getDarkTheme()` 方法类似操作。

## 🚢 发布应用

### Android APK

```bash
flutter build apk --release
# 输出: build/app/outputs/flutter-apk/app-release.apk
```

### iOS IPA（需要 macOS）

```bash
flutter build ios --release
# 需要在 Xcode 中配置签名证书
```

### Web

```bash
flutter build web
# 输出: build/web/
```

### Desktop

```bash
flutter build windows  # Windows
flutter build macos    # macOS
flutter build linux    # Linux
```

## 🔮 未来计划

- [ ] 小时级天气预报
- [ ] 空气质量指数 (AQI)
- [ ] 恶劣天气预警
- [ ] 多语言支持（英文、日文等）
- [ ] 桌面端 Widget
- [ ] Apple Watch 支持
- [ ] Android Widget

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📄 许可证

本项目仅供学习和个人使用。

## 🙏 致谢

- [Flutter Team](https://flutter.dev/) - 优秀的跨平台框架
- [WeatherAPI.com](https://www.weatherapi.com/) - 免费天气数据 API
- [fl_chart](https://pub.dev/packages/fl_chart) - 强大的图表库
- [pub.dev](https://pub.dev/) - Dart 包管理平台

---

**版本**: 2.0.0
**创建时间**: 2025-11-17
**最后更新**: 2025-11-17
**开发者**: LhhMiracle

如有问题或建议，欢迎提Issue！
