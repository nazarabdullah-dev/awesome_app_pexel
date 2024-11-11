import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awesome_app/image_pexel/models/image_data.dart'; // Import the new models file

class ImageDetailScreen extends StatelessWidget {
  final ImageData image;

  const ImageDetailScreen({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Hero(
                tag: 'image_${image.url}',
                child: Image.network(
                  image.src.portrait,
                  width: double.infinity,
                  height: 1.sh * 0.632,
                  frameBuilder:
                      (context, child, frame, wasSynchronouslyLoaded) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey,
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: child,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Photographer: ${image.photographer}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'URL: ${image.src.original}',
              style: const TextStyle(fontSize: 18),
            ),
            // Add more details if needed
          ],
        ),
      ),
    );
  }
}
