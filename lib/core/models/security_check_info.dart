class SecurityCheckInfo {
  final String title;
  final String whatItChecks;
  final String whyItMatters;
  final String whatResultMeans;
  final String limitation;

  const SecurityCheckInfo({
    required this.title,
    required this.whatItChecks,
    required this.whyItMatters,
    required this.whatResultMeans,
    required this.limitation,
  });
}

class SecurityCheckInfoProvider {
  SecurityCheckInfoProvider._();

  static SecurityCheckInfo get(String id) {
    switch (id) {
      case 'root':
        return const SecurityCheckInfo(
          title: 'Root Status',
          whatItChecks:
              'Checks for indicators that the device operating system has '
              'been modified to provide elevated system access.',
          whyItMatters:
              'Rooting or jailbreaking can be useful for advanced '
              'customization, development, testing, or system-level control. '
              'However, modifying the operating system can reduce some of '
              'the security protections normally provided by the platform.',
          whatResultMeans:
              'A positive result means that MocoSense observed indicators '
              'associated with a modified or elevated device environment. '
              'It does not mean that the device has been hacked.',
          limitation:
              'This is an indicator-based check, not a complete security '
              'assessment. A device can be modified in ways that this check '
              'does not detect.',
        );

      case 'real_device':
        return const SecurityCheckInfo(
          title: 'Device Environment',
          whatItChecks:
              'Checks whether the application appears to be running on a '
              'physical device or a virtual/emulated environment.',
          whyItMatters:
              'Emulators and virtual environments are useful for development '
              'and testing. They can also behave differently from a physical '
              'device and may provide a different security environment.',
          whatResultMeans:
              'A physical-device result means the application appears to be '
              'running on real device hardware. An emulator result means the '
              'application appears to be running in a virtual environment.',
          limitation:
              'This check identifies the environment available to the '
              'application. It does not determine whether a physical device '
              'is secure or compromised.',
        );

      case 'developer_mode':
        return const SecurityCheckInfo(
          title: 'Developer Mode',
          whatItChecks:
              'Checks whether Android development options are enabled.',
          whyItMatters:
              'Developer options provide useful tools for development, '
              'testing, debugging, and device configuration. Having them '
              'enabled does not by itself mean that a device is insecure.',
          whatResultMeans:
              'An enabled result means Android development options are '
              'currently enabled on the device.',
          limitation:
              'MocoSense does not treat developer mode alone as proof of a '
              'security problem. The check only reports the observed device '
              'configuration.',
        );

      case 'device_auth':
        return const SecurityCheckInfo(
          title: 'Device Authentication',
          whatItChecks:
              'Checks whether the device provides a supported local '
              'authentication mechanism.',
          whyItMatters:
              'Device authentication can help protect access to the device '
              'and applications from unauthorized users.',
          whatResultMeans:
              'A supported result means the device exposes a supported '
              'authentication capability to the application.',
          limitation:
              'This check does not verify that the user has configured the '
              'strongest possible authentication method or that the device '
              'cannot be accessed by someone else.',
        );

      case 'biometric_hardware':
        return const SecurityCheckInfo(
          title: 'Biometric Capability',
          whatItChecks:
              'Checks whether biometric authentication hardware is available '
              'to the application.',
          whyItMatters:
              'Biometric authentication can provide a convenient way to '
              'authenticate users using supported device hardware.',
          whatResultMeans:
              'A positive result means compatible biometric capability was '
              'detected. It does not mean that a fingerprint or face is '
              'currently enrolled.',
          limitation:
              'Hardware availability and biometric enrollment are different '
              'things. This check only reports capability.',
        );

      case 'biometric_enrollment':
        return const SecurityCheckInfo(
          title: 'Biometric Enrollment',
          whatItChecks:
              'Checks whether at least one biometric credential is enrolled '
              'on the device.',
          whyItMatters:
              'Enrollment allows supported biometric authentication methods '
              'to be used when an application requests them.',
          whatResultMeans:
              'An enrolled result means the device reports that at least one '
              'supported biometric credential is enrolled.',
          limitation:
              'No enrolled biometric does not automatically mean the device '
              'is insecure. Users may intentionally choose another '
              'authentication method.',
        );

      default:
        return const SecurityCheckInfo(
          title: 'Security Check',
          whatItChecks:
              'MocoSense observed a security-related signal from the device.',
          whyItMatters:
              'Security signals can provide useful information about the '
              'device environment.',
          whatResultMeans:
              'The result represents what MocoSense was able to observe.',
          limitation:
              'This check is not a complete security assessment of the device.',
        );
    }
  }
}
