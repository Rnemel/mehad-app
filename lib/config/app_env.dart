class AppEnv {
  static const String apiBaseUrl = String.fromEnvironment(
    'MEHAD_API_BASE_URL',
    defaultValue: '',
  );

  static const bool enableBackend = bool.fromEnvironment(
    'MEHAD_ENABLE_BACKEND',
    defaultValue: false,
  );

  static const bool enableWatch = bool.fromEnvironment(
    'MEHAD_ENABLE_WATCH',
    defaultValue: false,
  );
}

