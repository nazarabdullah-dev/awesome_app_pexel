import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:awesome_app/image_pexel/repository/pexels_api.dart';
import 'package:awesome_app/image_pexel/models/image_data.dart'; // Import the new models file

enum ViewType { grid, list }

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

class ImageProviderEvent {}

class FetchImages extends ImageProviderEvent {
  final bool isNextPage;

  FetchImages({this.isNextPage = false});
}

class ChangeViewType extends ImageProviderEvent {
  final ViewType viewType;

  ChangeViewType(this.viewType);
}

class ImageProviderBloc extends Bloc<ImageProviderEvent, ImageProviderState> {
  final PexelsApi api;

  ImageProviderBloc({PexelsApi? api})
      : api = api ?? PexelsApi(),
        super(const ImageProviderState(
          images: [],
          viewType: ViewType.grid,
          isLoading: false,
          hasError: false,
          page: 1,
        )) {
    on<FetchImages>(_onFetchImages);
    on<ChangeViewType>(_onChangeViewType);
  }

  void _onFetchImages(
      FetchImages event, Emitter<ImageProviderState> emit) async {
    emit(state.copyWith(isLoading: true, hasError: false));
    try {
      final nextPage = event.isNextPage ? state.page + 1 : 1;
      final images = await api.fetchImages(page: nextPage);
      emit(state.copyWith(
        images: event.isNextPage ? [...state.images, ...images] : images,
        isLoading: false,
        page: nextPage,
      ));
    } catch (_) {
      emit(state.copyWith(isLoading: false, hasError: true));
    }
  }

  void _onChangeViewType(
      ChangeViewType event, Emitter<ImageProviderState> emit) {
    emit(state.copyWith(viewType: event.viewType));
  }
}
