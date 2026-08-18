import 'package:safe_device/safe_device.dart';

class DeviceSecurityService {
  Future<bool> isJailBroken() async {
    return SafeDevice.isJailBroken;
  }

  Future<bool> isRealDevice() async {
    return SafeDevice.isRealDevice;
  }

  Future<bool> isDevelopmentModeEnabled() async {
    return SafeDevice.isDevelopmentModeEnable;
  }
}
