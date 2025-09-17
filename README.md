# jlt_app_log_handler

A simple, extensible logging and notification handler for Flutter apps. This package provides unified logging methods (success, info, debug, error) and toast notifications, built on top of [talker_flutter](https://pub.dev/packages/talker_flutter) and [toastification](https://pub.dev/packages/toastification).

## Features

- Unified logging interface: success, info, debug, error
- Optional toast notifications for log events
- Pretty-printing for long messages (Map/List)
- Customizable log IDs and separators
- Stack trace logging for errors
- Easy integration with Flutter

## Getting Started

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  jlt_app_log_handler:
    git:
      url: https://github.com/yourusername/jlt_app_log_handler.git
```

Or from pub.dev (when published):

```yaml
dependencies:
  jlt_app_log_handler: ^<latest_version>
```

Run `flutter pub get` to install dependencies.

## Usage

Import and use the `LogHandler` class in your Flutter app:

```dart
import 'package:jlt_app_log_handler/jlt_app_log_handler.dart';

final logHandler = LogHandler();

// Success log with toast
logHandler.success(message: 'Operation completed!', showToast: true);

// Info log
logHandler.info(message: 'Fetching data...');

// Debug log (only in debug mode)
logHandler.debug(message: 'Debugging value', longMessage: {'key': 'value'});

// Error log with stack trace and toast
try {
  throw Exception('Something went wrong');
} catch (e, st) {
  logHandler.error(e: e, stackTrace: st, showToast: true);
}
```

## API Reference

See [lib/src/log_handler.dart](lib/src/log_handler.dart) for full API details.

### LogHandler Methods
- `success({required String message, ...})`
- `info({required String message, ...})`
- `debug({required String message, ...})`
- `error({required e, StackTrace? stackTrace, ...})`

All methods support optional toast notifications and long messages.

## Example

See the `/example` folder for a complete Flutter app using this package.

## Contributing

Contributions are welcome! Please open issues or submit pull requests on [GitHub](https://github.com/yourusername/jlt_app_log_handler).

## Issues

Report issues via the [GitHub Issues](https://github.com/yourusername/jlt_app_log_handler/issues) page.

## License

This project is licensed under the [MIT License](LICENSE).

## Additional Information

- [talker_flutter documentation](https://pub.dev/packages/talker_flutter)
- [toastification documentation](https://pub.dev/packages/toastification)
- For questions, contact the package author via GitHub.
