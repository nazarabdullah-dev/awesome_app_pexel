part of 'connectivity_bloc.dart';

abstract class ConnectivityEvent extends Equatable {
  const ConnectivityEvent();

  @override
  List<Object> get props => [];
}

class ConnectivityChanged extends ConnectivityEvent {
  final ConnectivityResult connectivityResult;

  const ConnectivityChanged(this.connectivityResult);

  @override
  List<Object> get props => [connectivityResult];
}
