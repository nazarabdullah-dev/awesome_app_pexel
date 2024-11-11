import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final Connectivity _connectivity;

  ConnectivityBloc({Connectivity? connectivity})
      : _connectivity = connectivity ?? Connectivity(),
        super(ConnectivityInitial()) {
    on<ConnectivityChanged>(_onConnectivityChanged);
    _connectivity.onConnectivityChanged.listen((result) {
      add(ConnectivityChanged(result.first));
    });
  }

  void _onConnectivityChanged(
      ConnectivityChanged event, Emitter<ConnectivityState> emit) {
    if (event.connectivityResult == ConnectivityResult.none) {
      emit(ConnectivityFailure());
    } else {
      emit(ConnectivitySuccess());
    }
  }
}
