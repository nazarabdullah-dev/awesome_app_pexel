import 'package:awesome_app/core/utils/extension.dart';
import 'package:awesome_app/core/widgets/base_state.dart';
import 'package:flutter/material.dart';
import 'package:awesome_app/image_pexel/models/image_data.dart'; // Import the new models file
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart'; // Import the url_launcher package

class ImageDetailScreen extends StatefulWidget {
  final ImageData image;

  const ImageDetailScreen({super.key, required this.image});

  @override
  State<ImageDetailScreen> createState() => _ImageDetailScreenState();
}

class _ImageDetailScreenState extends BaseState<ImageDetailScreen> {
  final DraggableScrollableController _scrollableController =
      DraggableScrollableController();

  @override
  void dispose() {
    _scrollableController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor:
            HexColor.fromHex(widget.image.avgColor).withOpacity(0.8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Image Details',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _scrollableController,
            builder: (context, child) {
              return Positioned.fill(
                bottom: _scrollableController.isAttached
                    ? _scrollableController.pixels - 20
                    : 0,
                child: Hero(
                  tag: 'image_${widget.image.url}',
                  child: Image.network(
                    widget.image.src.portrait,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
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
              );
            },
          ),
          DraggableScrollableSheet(
            controller: _scrollableController,
            initialChildSize: 0.2,
            minChildSize: 0.2,
            maxChildSize: 0.5,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        Text(
                          'Photographer: ${widget.image.photographer} ${widget.image.avgColor}',
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () async {
                            final url = widget.image.url;
                            if (await canLaunchUrl(Uri.parse(url))) {
                              await launchUrl(Uri.parse(url));
                            }
                          },
                          child: Text(
                            'URL: ${widget.image.url}',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        // Add more details if needed
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
