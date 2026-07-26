import 'app_environment.dart';
import 'env_config.dart';

class DartDefineEnv {
  static EnvConfig load() {
    const envRaw = String.fromEnvironment('ENV');
    const apiBaseUrl = String.fromEnvironment('API_BASE_URL');
    const enableVerboseLogs = bool.fromEnvironment('ENABLE_VERBOSE_LOGS', defaultValue: false);
    const allowMockData = bool.fromEnvironment('ALLOW_MOCK_DATA', defaultValue: false);

    if (envRaw.isEmpty) {
      throw Exception('ENV is required (dev | staging | prod)');
    }

    if (apiBaseUrl.isEmpty) {
      throw Exception('API_BASE_URL is required');
    }

    final environment = switch (envRaw) {
      'dev' => AppEnvironment.dev,
      'staging' => AppEnvironment.staging,
      'prod' => AppEnvironment.prod,
      _ => throw Exception('Invalid ENV value: $envRaw'),
    };

    return EnvConfig(
      environment: environment,
      apiBaseUrl: apiBaseUrl,
      enableVerboseLogs: enableVerboseLogs,
      allowMockData: allowMockData,
    );
  }
}