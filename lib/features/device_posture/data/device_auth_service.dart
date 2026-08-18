import 'package:local_auth/local_auth.dart';

class DeviceAuthService {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> isDeviceAuthenticationSupported() async {
    return _auth.isDeviceSupported();
  }

  Future<bool> hasBiometricHardware() async {
    return _auth.canCheckBiometrics;
  }

  Future<bool> hasEnrolledBiometrics() async {
    final biometrics = await _auth.getAvailableBiometrics();
    return biometrics.isNotEmpty;
  }
}