import 'package:mocosense/features/device_posture/domain/device_posture_result.dart';

abstract class DevicePostureRepository {
  Future<DevicePostureResult> runAudit();
}
