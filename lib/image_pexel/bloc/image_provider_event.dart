enum ViewType { grid, list }

abstract class ImageProviderEvent {}

class FetchImages extends ImageProviderEvent {
  final bool isNextPage;
  final isPulltoRefresh;

  FetchImages({this.isNextPage = false, this.isPulltoRefresh = false});
}

class ChangeViewType extends ImageProviderEvent {
  final ViewType viewType;

  ChangeViewType(this.viewType);
}
