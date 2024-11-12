enum ViewType { grid, list }

abstract class ImageProviderEvent {}

class FetchImages extends ImageProviderEvent {
  final bool isNextPage;

  FetchImages({this.isNextPage = false});
}

class ChangeViewType extends ImageProviderEvent {
  final ViewType viewType;

  ChangeViewType(this.viewType);
}
