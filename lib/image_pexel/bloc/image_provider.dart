import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awesome_app/image_pexel/repository/pexels_api.dart';
import 'package:awesome_app/image_pexel/bloc/image_provider_event.dart'; // Import the new event file
import 'package:awesome_app/image_pexel/bloc/image_provider_state.dart'; // Import the new state file

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
