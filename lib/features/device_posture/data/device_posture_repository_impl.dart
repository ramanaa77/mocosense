import 'package:mocosense/core/models/security_check_result.dart';
import 'package:mocosense/features/device_posture/data/device_auth_service.dart';
import 'package:mocosense/features/device_posture/data/device_security_service.dart';
import 'package:mocosense/features/device_posture/domain/device_posture_repository.dart';
import 'package:mocosense/features/device_posture/domain/device_posture_result.dart';

class DevicePostureRepositoryImpl implements DevicePostureRepository {
  final DeviceSecurityService deviceSecurityService;
  final DeviceAuthService deviceAuthService;

  DevicePostureRepositoryImpl({
    required this.deviceSecurityService,
    required this.deviceAuthService,
  });

  @override
  Future<DevicePostureResult> runAudit() async {
    final isJailBroken = await deviceSecurityService.isJailBroken();

    final isRealDevice = await deviceSecurityService.isRealDevice();

    final isDevelopmentModeEnabled = await deviceSecurityService
        .isDevelopmentModeEnabled();

    final isDeviceAuthSupported = await deviceAuthService
        .isDeviceAuthenticationSupported();

    final hasBiometricHardware = await deviceAuthService.hasBiometricHardware();

    final hasEnrolledBiometrics = await deviceAuthService
        .hasEnrolledBiometrics();

    return DevicePostureResult(
      checks: [
        SecurityCheckResult(
          id: 'root',
          title: 'Root / Jailbreak',
          description: isJailBroken
              ? 'A root or jailbreak indicator was observed.'
              : 'No root or jailbreak indicator was observed.',
          status: isJailBroken ? SecurityStatus.critical : SecurityStatus.pass,
        ),
        SecurityCheckResult(
          id: 'real_device',
          title: 'Device Environment',
          description: isRealDevice
              ? 'The application appears to be running on a physical device.'
              : 'The application appears to be running in an emulator or virtual environment.',
          status: isRealDevice ? SecurityStatus.pass : SecurityStatus.info,
        ),
        SecurityCheckResult(
          id: 'developer_mode',
          title: 'Developer Mode',
          description: isDevelopmentModeEnabled
              ? 'Android development options are enabled.'
              : 'Android development options were not detected as enabled.',
          status: isDevelopmentModeEnabled
              ? SecurityStatus.warning
              : SecurityStatus.pass,
        ),
        SecurityCheckResult(
          id: 'device_auth',
          title: 'Device Authentication',
          description: isDeviceAuthSupported
              ? 'Device-level authentication is supported.'
              : 'Device-level authentication is not supported.',
          status: isDeviceAuthSupported
              ? SecurityStatus.pass
              : SecurityStatus.warning,
        ),
        SecurityCheckResult(
          id: 'biometric_hardware',
          title: 'Biometric Capability',
          description: hasBiometricHardware
              ? 'Biometric authentication hardware is available.'
              : 'No biometric authentication capability was detected.',
          status: hasBiometricHardware
              ? SecurityStatus.pass
              : SecurityStatus.info,
        ),
        SecurityCheckResult(
          id: 'biometric_enrollment',
          title: 'Biometric Enrollment',
          description: hasEnrolledBiometrics
              ? 'At least one biometric is enrolled.'
              : 'No enrolled biometric was detected.',
          status: hasEnrolledBiometrics
              ? SecurityStatus.pass
              : SecurityStatus.info,
        ),
      ],
    );
  }
}
