# Awesome App

## Cloning the Repository

To clone the repository, run the following command:

```sh
git clone https://github.com/yourusername/awesome_app.git
cd awesome_app
```

## Setting Up Environment Variables

This project uses `dotenv` to manage environment variables. Follow these steps to set up your `PEXELS_API_KEY`:

1. Create a `main.env` file in the root directory of the project.
2. Add your `PEXELS_API_KEY` to the `main.env` file:

```
PEXELS_API_KEY=your_pexels_api_key_here
```

3. Ensure you have the `flutter_dotenv` package in your `pubspec.yaml`:

```yaml
dependencies:
	flutter:
		sdk: flutter
	flutter_dotenv: ^5.0.2
```

4. Load the environment variables in your `main.dart`:

```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
	await dotenv.load(fileName: "main.env");
	runApp(MyApp());
}
```

## Running Tests

### Unit Tests

To run unit tests, use the following command:

```sh
flutter test
```

### UI Tests

To run UI tests, use the following command:

```sh
flutter test integration_test/intrumentation_test.dart
```


## Additional Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [dotenv Package](https://pub.dev/packages/flutter_dotenv)
