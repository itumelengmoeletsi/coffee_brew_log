import 'app_environment.dart';

class EnvConfig {
  final AppEnvironment environment;
  final String apiBaseUrl;
  final bool allowMockData;
  final bool enableVerboseLogs;

  const EnvConfig ({
    required this.environment,
    required this.apiBaseUrl,
    required this.allowMockData,
    required this.enableVerboseLogs
  });
}