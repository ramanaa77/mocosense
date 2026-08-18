enum SecurityStatus { pass, warning, critical, info, unavailable }

class SecurityCheckResult {
  final String id;
  final String title;
  final String description;
  final SecurityStatus status;

  const SecurityCheckResult({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
  });
}
