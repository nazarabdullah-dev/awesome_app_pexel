import 'dart:async';
import 'dart:convert';

import 'package:awesome_app/mock_main.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

// Create a mock class for Connectivity
class MockConnectivity extends Mock implements Connectivity {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Check internet connectivity and show dialog',
      (WidgetTester tester) async {
    final mockHttpClient = MockClient((request) async {
      final response = {
        "page": 1,
        "per_page": 1,
        "photos": [
          {
            "id": 2880507,
            "width": 4000,
            "height": 6000,
            "url":
                "https://www.pexels.com/photo/woman-in-white-long-sleeved-top-and-skirt-standing-on-field-2880507/",
            "photographer": "Deden Dicky Ramdhani",
            "photographer_url": "https://www.pexels.com/@drdeden88",
            "photographer_id": 1378810,
            "avg_color": "#7E7F7B",
            "src": {
              "original":
                  "https://images.pexels.com/photos/2880507/pexels-photo-2880507.jpeg",
              "large2x":
                  "https://images.pexels.com/photos/2880507/pexels-photo-2880507.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
              "large":
                  "https://images.pexels.com/photos/2880507/pexels-photo-2880507.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
              "medium":
                  "https://images.pexels.com/photos/2880507/pexels-photo-2880507.jpeg?auto=compress&cs=tinysrgb&h=350",
              "small":
                  "https://images.pexels.com/photos/2880507/pexels-photo-2880507.jpeg?auto=compress&cs=tinysrgb&h=130",
              "portrait":
                  "https://images.pexels.com/photos/2880507/pexels-photo-2880507.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
              "landscape":
                  "https://images.pexels.com/photos/2880507/pexels-photo-2880507.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
              "tiny":
                  "https://images.pexels.com/photos/2880507/pexels-photo-2880507.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"
            },
            "liked": false,
            "alt": "Brown Rocks During Golden Hour"
          }
        ],
        "next_page": "https://api.pexels.com/v1/curated/?page=2&per_page=1"
      };
      return http.Response(json.encode(response), 200);
    });
    // Mock connectivity result
    final mockConnectivity = MockConnectivity();
    final connectivityStream = StreamController<List<ConnectivityResult>>();
    when(() => mockConnectivity.onConnectivityChanged)
        .thenAnswer((_) => connectivityStream.stream);
    // Build the app and trigger a frame
    await tester.pumpWidget(MockMainApp(
      connectivity: mockConnectivity,
      mockHttpClient: mockHttpClient,
    ));

    // Wait for the dialog to appear
    await tester.pumpAndSettle();

    connectivityStream.add([ConnectivityResult.none]);

    await tester.pumpAndSettle();

    // Verify that the dialog is shown
    expect(find.text('No Internet Connection'), findsOneWidget);

    connectivityStream.add([ConnectivityResult.wifi]);
    await tester.pumpAndSettle();

    await tester.tap(find.text('OK'));

    await tester.pumpAndSettle();

    expect(find.byKey(const Key('2880507')), findsOneWidget);

    // Close the dialog
    await tester.tap(find.byKey(const Key('2880507')));
    await tester.pumpAndSettle();

    // Verify that the dialog is closed
    expect(find.text('Image Details'), findsOneWidget);
  });
}
