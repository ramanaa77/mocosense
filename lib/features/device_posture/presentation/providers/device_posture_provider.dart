import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocosense/features/device_posture/data/device_auth_service.dart';
import 'package:mocosense/features/device_posture/data/device_posture_repository_impl.dart';
import 'package:mocosense/features/device_posture/data/device_security_service.dart';
import 'package:mocosense/features/device_posture/domain/device_posture_result.dart';

final devicePostureRepositoryProvider = Provider<DevicePostureRepositoryImpl>((
  ref,
) {
  return DevicePostureRepositoryImpl(
    deviceAuthService: DeviceAuthService(),
    deviceSecurityService: DeviceSecurityService(),
  );
});

final devicePostureProvider =
    AsyncNotifierProvider<DevicePostureNotifier, DevicePostureResult>(
      DevicePostureNotifier.new,
    );

class DevicePostureNotifier extends AsyncNotifier<DevicePostureResult> {
  @override
  Future<DevicePostureResult> build() async {
    return const DevicePostureResult(checks: []);
  }

  Future<void> runAudit() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final repository = ref.read(devicePostureRepositoryProvider);

      return repository.runAudit();
    });
  }
}
