# WeatherApp - iOS 天气应用

一个使用 Swift 和 SwiftUI 开发的简洁、现代化的天气应用。

## 功能特性

- ✅ 实时天气查询
- ✅ 支持城市名称搜索（支持中文）
- ✅ 显示温度、湿度、风速等详细信息
- ✅ 美观的渐变 UI 设计
- ✅ SwiftUI 现代化界面
- ✅ 支持 iOS 15.0+

## 项目结构

```
WeatherApp/
├── WeatherApp/
│   ├── WeatherAppApp.swift          # 应用入口
│   ├── ContentView.swift             # 主视图
│   ├── Models/
│   │   └── WeatherData.swift         # 数据模型
│   ├── Views/
│   │   └── WeatherView.swift         # 天气显示视图
│   ├── ViewModels/
│   │   └── WeatherViewModel.swift    # 视图模型
│   ├── Services/
│   │   └── WeatherService.swift      # 天气 API 服务
│   ├── Assets.xcassets/              # 资源文件
│   └── Info.plist                    # 应用配置
├── WeatherApp.xcodeproj/             # Xcode 项目文件
└── README.md                         # 项目说明
```

## 技术栈

- **语言**: Swift 5.0
- **框架**: SwiftUI
- **架构**: MVVM (Model-View-ViewModel)
- **最低支持**: iOS 15.0
- **API**: WeatherAPI.com

## 安装步骤

### 1. 克隆项目

```bash
git clone https://github.com/LhhMiracle/NewMiracle.git
cd NewMiracle
```

### 2. 获取 API Key

1. 访问 [WeatherAPI.com](https://www.weatherapi.com/)
2. 免费注册账号
3. 获取你的 API Key

### 3. 配置 API Key

打开 `WeatherApp/Services/WeatherService.swift` 文件，将 `YOUR_API_KEY_HERE` 替换为你的 API Key：

```swift
private let apiKey = "你的API_KEY"
```

### 4. 在 Xcode 中打开

```bash
open WeatherApp.xcodeproj
```

**注意**: 此项目需要在 macOS 上使用 Xcode 打开和编译。

### 5. 运行应用

1. 选择目标设备（模拟器或真机）
2. 点击运行按钮（⌘R）

## 使用说明

1. 启动应用后，在搜索框中输入城市名称（支持中文，如"北京"、"上海"）
2. 点击搜索按钮
3. 查看详细的天气信息，包括：
   - 当前温度（摄氏度/华氏度）
   - 天气状况
   - 体感温度
   - 湿度
   - 风速
   - 紫外线指数

## 主要文件说明

### WeatherData.swift
定义了天气数据的结构，包括：
- `WeatherResponse`: 完整的天气响应
- `Location`: 位置信息
- `CurrentWeather`: 当前天气数据
- `WeatherCondition`: 天气状况

### WeatherService.swift
处理天气 API 调用：
- 支持按城市名称查询
- 支持按经纬度查询
- 使用 async/await 进行异步网络请求

### WeatherViewModel.swift
MVVM 架构的 ViewModel 层：
- 管理天气数据状态
- 处理加载状态
- 处理错误信息

### ContentView.swift
主界面视图：
- 搜索输入框
- 加载指示器
- 错误提示
- 天气信息展示

### WeatherView.swift
天气详情展示：
- 城市和地区信息
- 温度和天气状况
- 详细气象数据卡片

## API 说明

本项目使用 [WeatherAPI.com](https://www.weatherapi.com/) 提供的免费天气 API。

### API 端点
```
GET https://api.weatherapi.com/v1/current.json
```

### 查询参数
- `key`: API 密钥
- `q`: 城市名称或经纬度
- `aqi`: 空气质量指数（设置为 no）

## 系统要求

- macOS 12.0+ (用于开发)
- Xcode 15.0+
- iOS 15.0+ (用于运行)
- Swift 5.0+

## 后续改进计划

- [ ] 添加定位功能，自动获取当前位置天气
- [ ] 支持多天天气预报
- [ ] 添加收藏城市功能
- [ ] 支持深色模式优化
- [ ] 添加天气图标动画
- [ ] 支持多语言（中文/英文）
- [ ] 添加单元测试

## 开发者

LhhMiracle

## 许可证

本项目仅供学习和个人使用。

## 常见问题

### Q: 为什么无法获取天气数据？
A: 请检查：
1. 是否正确配置了 API Key
2. 网络连接是否正常
3. Info.plist 中是否允许了网络访问权限

### Q: 支持哪些城市？
A: 支持全球主要城市，可以使用中文或英文名称搜索。

### Q: 可以在 Linux 或 Windows 上运行吗？
A: 本项目是原生 iOS 应用，必须在 macOS 上使用 Xcode 编译和运行。

## 致谢

- [WeatherAPI.com](https://www.weatherapi.com/) 提供天气数据 API
- [Apple SwiftUI](https://developer.apple.com/xcode/swiftui/) 框架

---

**开始时间**: 2025-11-17
**版本**: 1.0.0
