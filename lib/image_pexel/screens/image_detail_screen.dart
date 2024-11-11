import 'package:awesome_app/core/widgets/base_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awesome_app/image_pexel/models/image_data.dart'; // Import the new models file

class ImageDetailScreen extends StatefulWidget {
  final ImageData image;

  const ImageDetailScreen({super.key, required this.image});

  @override
  State<ImageDetailScreen> createState() => _ImageDetailScreenState();
}

class _ImageDetailScreenState extends BaseState<ImageDetailScreen> {
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
                tag: 'image_${widget.image.url}',
                child: Image.network(
                  widget.image.src.portrait,
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
              'Photographer: ${widget.image.photographer}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'URL: ${widget.image.src.original}',
              style: const TextStyle(fontSize: 18),
            ),
            // Add more details if needed
          ],
        ),
      ),
    );
  }
}
