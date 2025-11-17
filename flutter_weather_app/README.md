# Flutter Weather App - 跨平台天气应用

一个使用 Flutter 和 Dart 开发的现代化跨平台天气应用，支持 iOS、Android、Web、Windows、macOS 和 Linux。

## 功能特性

- ✅ 实时天气查询
- ✅ 支持城市名称搜索（中文/英文）
- ✅ 显示温度、湿度、风速、紫外线指数
- ✅ 美观的渐变 UI 设计
- ✅ 跨平台支持（iOS、Android、Web、Desktop）
- ✅ 响应式布局
- ✅ 网络请求错误处理

## 项目结构

```
flutter_weather_app/
├── lib/
│   ├── main.dart                    # 应用入口
│   ├── models/
│   │   └── weather_model.dart       # 天气数据模型
│   ├── services/
│   │   └── weather_service.dart     # API 服务
│   ├── screens/
│   │   └── home_screen.dart         # 主页面
│   └── widgets/
│       └── weather_display.dart     # 天气显示组件
├── assets/                          # 资源文件
├── pubspec.yaml                     # 项目配置
├── analysis_options.yaml            # 代码分析配置
└── README.md                        # 项目文档
```

## 技术栈

- **框架**: Flutter 3.x
- **语言**: Dart 2.17+
- **网络请求**: http package
- **架构**: 分层架构（Model-Service-UI）
- **API**: WeatherAPI.com

## 前置要求

### 必须安装

1. **Flutter SDK** (3.0.0 或更高版本)
   - 下载地址: https://flutter.dev/docs/get-started/install

2. **Dart SDK** (通常随 Flutter 一起安装)

3. **开发工具**（任选其一）:
   - VS Code + Flutter 插件
   - Android Studio + Flutter 插件
   - IntelliJ IDEA + Flutter 插件

### 可选（根据目标平台）

- **Android 开发**: Android SDK, Android Studio
- **iOS 开发**: macOS, Xcode
- **Web 开发**: Chrome 浏览器
- **Desktop 开发**: 对应平台的编译工具

## 快速开始

### 1. 检查 Flutter 环境

```bash
flutter --version
flutter doctor
```

确保 `flutter doctor` 显示所有必需项都已正确安装。

### 2. 克隆项目

```bash
# 克隆仓库
git clone https://github.com/LhhMiracle/NewMiracle.git
cd NewMiracle

# 切换到代码分支
git checkout claude/analyze-repo-structure-01HYZwPf1MdkqndmoADAnkEa

# 进入 Flutter 项目目录
cd flutter_weather_app
```

### 3. 获取 API Key

1. 访问 [WeatherAPI.com](https://www.weatherapi.com/)
2. 免费注册账号
3. 在 Dashboard 中获取你的 API Key

### 4. 配置 API Key

打开 `lib/services/weather_service.dart` 文件，找到第 10 行：

```dart
static const String _apiKey = 'YOUR_API_KEY_HERE';
```

替换为你的真实 API Key：

```dart
static const String _apiKey = '你的API_KEY';
```

### 5. 安装依赖

```bash
flutter pub get
```

### 6. 运行应用

#### 在模拟器/真机上运行

```bash
# 查看可用设备
flutter devices

# 运行在默认设备
flutter run

# 运行在指定设备
flutter run -d <device_id>
```

#### 运行在不同平台

```bash
# Android
flutter run -d android

# iOS（需要 macOS）
flutter run -d ios

# Web
flutter run -d chrome

# Windows
flutter run -d windows

# macOS
flutter run -d macos

# Linux
flutter run -d linux
```

## 使用说明

1. 启动应用后，你会看到一个蓝紫色渐变背景的界面
2. 在搜索框中输入城市名称，例如：
   - 中文：**北京**、**上海**、**广州**、**深圳**
   - 英文：**New York**、**London**、**Tokyo**
3. 点击搜索按钮 🔍 或按回车键
4. 查看实时天气信息：
   - 🌡️ 当前温度和体感温度
   - 🌤️ 天气状况
   - 💧 湿度百分比
   - 🌬️ 风速
   - ☀️ 紫外线指数
   - 🌡️ 华氏温度

## 构建发布版本

### Android APK

```bash
flutter build apk --release
```

生成的 APK 位于 `build/app/outputs/flutter-apk/app-release.apk`

### iOS IPA（需要 macOS）

```bash
flutter build ios --release
```

### Web

```bash
flutter build web
```

生成的文件位于 `build/web/`

### Windows

```bash
flutter build windows
```

### macOS

```bash
flutter build macos
```

### Linux

```bash
flutter build linux
```

## 开发说明

### 代码结构

- **models/**: 数据模型类，负责数据结构定义和 JSON 解析
- **services/**: 服务类，负责 API 调用和业务逻辑
- **screens/**: 页面/屏幕，完整的界面页面
- **widgets/**: 可复用的 UI 组件

### 添加新功能

1. 在对应目录创建新文件
2. 遵循现有代码风格
3. 运行 `flutter analyze` 检查代码质量
4. 运行 `flutter test` 确保测试通过

## 常见问题

### Q: 无法获取天气数据？

**A**: 检查以下几点：
- ✅ API Key 是否正确配置
- ✅ 网络连接是否正常
- ✅ 城市名称拼写是否正确
- ✅ API 配额是否用完（免费版有限制）

### Q: Flutter 环境问题？

**A**: 运行以下命令诊断：
```bash
flutter doctor -v
flutter clean
flutter pub get
```

### Q: 编译错误？

**A**: 尝试清理项目：
```bash
flutter clean
flutter pub get
flutter pub upgrade
```

### Q: 在哪些平台可以开发？

**A**:
- **Windows**: 可开发 Android、Web、Windows 应用
- **macOS**: 可开发所有平台应用
- **Linux**: 可开发 Android、Web、Linux 应用

### Q: 相比原生 iOS 项目有什么优势？

**A**:
- ✅ 跨平台：一套代码，多端运行
- ✅ 开发环境：不限制 macOS，Windows/Linux 也能开发
- ✅ 热重载：快速开发调试
- ✅ 丰富的包生态：pub.dev 有大量现成的包

## 性能优化建议

1. 使用 `const` 构造函数减少重建
2. 合理使用 `setState` 避免不必要的重建
3. 图片使用缓存（已实现）
4. 大列表使用 `ListView.builder`

## 后续功能计划

- [ ] 定位功能（自动获取当前位置）
- [ ] 多日天气预报
- [ ] 收藏城市列表
- [ ] 深色模式
- [ ] 天气图表展示
- [ ] 离线缓存
- [ ] 多语言支持
- [ ] 单元测试和集成测试

## 学习资源

- [Flutter 官方文档](https://flutter.dev/docs)
- [Dart 语言教程](https://dart.dev/guides)
- [Flutter 中文网](https://flutter.cn/)
- [Pub.dev 包仓库](https://pub.dev/)

## 开发者

LhhMiracle

## 许可证

本项目仅供学习和个人使用。

## 致谢

- [Flutter Team](https://flutter.dev/) - 优秀的跨平台框架
- [WeatherAPI.com](https://www.weatherapi.com/) - 免费天气数据 API
- [pub.dev](https://pub.dev/) - Dart 包管理平台

---

**创建时间**: 2025-11-17
**版本**: 1.0.0
**Flutter**: 3.x
**Dart**: 2.17+
