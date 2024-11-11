import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'dart:convert';
import 'package:awesome_app/image_pexel/repository/pexels_api.dart';
import 'package:awesome_app/image_pexel/models/image_data.dart';

void main() {
  group('PexelsApi', () {
    test(
        'fetchImages returns a list of ImageData if the http call completes successfully',
        () async {
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

      final api = PexelsApi(httpClient: mockHttpClient);
      final images = await api.fetchImages();

      expect(images, isA<List<ImageData>>());
      expect(images.length, 1);
      expect(images[0].id, 2880507);

      final src = images[0].src;
      expect(src.original,
          'https://images.pexels.com/photos/2880507/pexels-photo-2880507.jpeg');
    });

    test(
        'fetchImages throws an exception if the http call completes with an error',
        () async {
      final mockHttpClient = MockClient((request) async {
        return http.Response('Not Found', 404);
      });

      final api = PexelsApi(httpClient: mockHttpClient);

      expect(api.fetchImages(), throwsException);
    });
  });
}
