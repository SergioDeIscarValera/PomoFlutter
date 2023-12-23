class StorageKeys {
  static final StorageKeys _singleton = StorageKeys._internal();

  factory StorageKeys() {
    return _singleton;
  }

  StorageKeys._internal();

  final String countWorkingSession = "COUNT_WORKING_SESSION";
  final String timeWorkingSession = "TIME_WORKING_SESSION";
  final String timeBreakSession = "TIME_BREAK_SESSION";
  final String timeLongBreakSession = "TIME_LONG_BREAK_SESSION";
  final String themeMode = "THEME_MODE"; // True is dark, false is light
}
