import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awesome_app/core/bloc/connectivity_bloc.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  late ConnectivityBloc _connectivityBloc;
  bool _isDialogShown = false;

  @override
  void initState() {
    super.initState();
    _connectivityBloc = context.read<ConnectivityBloc>();
    _connectivityBloc.stream.listen((state) {
      if (state is ConnectivityFailure && !_isDialogShown) {
        _showNoConnectivityDialog();
      }
    });
  }

  void _showNoConnectivityDialog() {
    setState(() {
      _isDialogShown = true;
    });
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('No Internet Connection'),
          content: const Text(
              'Please check your internet connection and try again.'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _isDialogShown = false;
                });
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _connectivityBloc.close();
    super.dispose();
  }
}
