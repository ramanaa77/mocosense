import 'package:mocosense/core/models/security_check_result.dart';

class DevicePostureResult {
  final List<SecurityCheckResult> checks;

  const DevicePostureResult({required this.checks});
}
