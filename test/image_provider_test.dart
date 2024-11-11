import 'package:awesome_app/image_pexel/models/image_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:awesome_app/image_pexel/bloc/image_provider.dart';
import 'package:awesome_app/image_pexel/repository/pexels_api.dart';
import 'package:mocktail/mocktail.dart';

class MockPexelsApi extends Mock implements PexelsApi {}

void main() {
  late MockPexelsApi mockApi;

  setUp(() {
    mockApi = MockPexelsApi();
  });

  final imageData = ImageData(
      id: 1,
      url: 'url1',
      width: 1,
      height: 1,
      photographerId: 1,
      avgColor: "avgColor1",
      photographer: 'photographer1',
      photographerUrl: 'photographerUrl1',
      src: Src(
          original: 'original1',
          portrait: 'portrait1',
          tiny: 'tiny1',
          large: 'large1',
          large2x: 'large2x1',
          medium: 'medium1',
          small: 'small1',
          landscape: 'landscape1'),
      liked: false,
      alt: 'alt1');

  blocTest<ImageProviderBloc, ImageProviderState>(
    'emits [loading, success] when FetchImages is added',
    build: () {
      when(() => mockApi.fetchImages(page: any(named: 'page')))
          .thenAnswer((_) async => [imageData]);
      return ImageProviderBloc(api: mockApi);
    },
    act: (bloc) => bloc.add(FetchImages()),
    expect: () => [
      const ImageProviderState(
        images: [],
        viewType: ViewType.grid,
        isLoading: true,
        hasError: false,
        page: 1,
      ),
      ImageProviderState(
        images: [imageData],
        viewType: ViewType.grid,
        isLoading: false,
        hasError: false,
        page: 1,
      ),
    ],
  );

  blocTest<ImageProviderBloc, ImageProviderState>(
    'emits [loading, error] when FetchImages fails',
    build: () {
      when(() => mockApi.fetchImages(page: any(named: 'page')))
          .thenThrow(Exception('error'));
      return ImageProviderBloc(api: mockApi);
    },
    act: (bloc) => bloc.add(FetchImages()),
    expect: () => [
      const ImageProviderState(
        images: [],
        viewType: ViewType.grid,
        isLoading: true,
        hasError: false,
        page: 1,
      ),
      const ImageProviderState(
        images: [],
        viewType: ViewType.grid,
        isLoading: false,
        hasError: true,
        page: 1,
      ),
    ],
  );

  blocTest<ImageProviderBloc, ImageProviderState>(
    'emits new viewType when ChangeViewType is added',
    build: () => ImageProviderBloc(),
    act: (bloc) => bloc.add(ChangeViewType(ViewType.list)),
    expect: () => [
      const ImageProviderState(
        images: [],
        viewType: ViewType.list,
        isLoading: false,
        hasError: false,
        page: 1,
      ),
    ],
  );
}
