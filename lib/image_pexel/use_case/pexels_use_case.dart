import 'package:awesome_app/image_pexel/repository/pexels_api.dart';
import 'package:awesome_app/image_pexel/repository/pexels_local.dart';
import 'package:awesome_app/image_pexel/models/image_data.dart';

class PexelsUseCase {
  final PexelsApi api;
  final PexelsLocalRepository localRepository;

  PexelsUseCase({required this.api, required this.localRepository});

  Future<List<ImageData>> getPaginatedImages(
      {int page = 1, int perPage = 16}) async {
    try {
      // Try to fetch from API
      final images = await api.fetchImages(page: page, perPage: perPage);
      // Save images to local database
      for (var image in images) {
        await localRepository.saveImageData(image);
      }
      return images;
    } catch (e) {
      // If API fails, fallback to local database
      return await localRepository.getPaginatedImages(
          page: page, perPage: perPage);
    }
  }
}
