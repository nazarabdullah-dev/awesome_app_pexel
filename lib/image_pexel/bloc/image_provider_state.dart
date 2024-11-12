import 'package:equatable/equatable.dart';
import 'package:awesome_app/image_pexel/models/image_data.dart';
import 'package:awesome_app/image_pexel/bloc/image_provider_event.dart'; // Import the event file for ViewType

class ImageProviderState extends Equatable {
  final List<ImageData> images;
  final ViewType viewType;
  final bool isLoading;
  final bool hasError;
  final int page;

  const ImageProviderState({
    required this.images,
    required this.viewType,
    required this.isLoading,
    required this.hasError,
    required this.page,
  });

  ImageProviderState copyWith({
    List<ImageData>? images,
    ViewType? viewType,
    bool? isLoading,
    bool? hasError,
    int? page,
  }) {
    return ImageProviderState(
      images: images ?? this.images,
      viewType: viewType ?? this.viewType,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      page: page ?? this.page,
    );
  }

  @override
  List<Object?> get props => [images, viewType, isLoading, hasError, page];
}
