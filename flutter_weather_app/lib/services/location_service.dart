import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

/// 定位服务类
/// 负责获取用户当前位置
class LocationService {
  /// 检查并请求定位权限
  Future<bool> requestLocationPermission() async {
    // 检查定位权限状态
    PermissionStatus status = await Permission.location.status;

    if (status.isDenied) {
      // 请求权限
      status = await Permission.location.request();
    }

    if (status.isPermanentlyDenied) {
      // 权限被永久拒绝，引导用户到设置页面
      await openAppSettings();
      return false;
    }

    return status.isGranted;
  }

  /// 检查定位服务是否启用
  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  /// 获取当前位置
  /// 返回 Position 对象，包含经纬度信息
  Future<Position?> getCurrentLocation() async {
    try {
      // 检查定位服务是否启用
      bool serviceEnabled = await isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('定位服务未启用，请在设置中开启');
      }

      // 检查权限
      bool hasPermission = await requestLocationPermission();
      if (!hasPermission) {
        throw Exception('定位权限被拒绝');
      }

      // 获取当前位置
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      return position;
    } catch (e) {
      print('获取位置失败: $e');
      rethrow;
    }
  }

  /// 获取当前位置的经纬度字符串
  /// 返回格式: "纬度,经度"
  Future<Map<String, double>?> getCurrentCoordinates() async {
    try {
      Position? position = await getCurrentLocation();
      if (position != null) {
        return {
          'latitude': position.latitude,
          'longitude': position.longitude,
        };
      }
      return null;
    } catch (e) {
      print('获取坐标失败: $e');
      return null;
    }
  }
}
