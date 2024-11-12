import 'package:awesome_app/core/bloc/connectivity_bloc.dart';
import 'package:awesome_app/image_pexel/bloc/image_provider_event.dart';
import 'package:awesome_app/image_pexel/repository/pexels_api.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awesome_app/image_pexel/bloc/image_provider.dart';
import 'package:awesome_app/image_pexel/screens/image_list_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
// New import

void main() {
  runApp(MockMainApp());
}

class MockMainApp extends StatelessWidget {
  MockMainApp(
      {super.key, http.Client? mockHttpClient, Connectivity? connectivity})
      : mockHttpClient = mockHttpClient ?? http.Client(),
        connectivity = connectivity ?? Connectivity();
  final http.Client mockHttpClient;
  final Connectivity connectivity;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<ImageProviderBloc>(
              create: (context) =>
                  ImageProviderBloc(api: PexelsApi(httpClient: mockHttpClient))
                    ..add(FetchImages()),
            ),
            BlocProvider<ConnectivityBloc>(
              create: (context) => ConnectivityBloc(connectivity: connectivity),
            )
          ],
          child: MaterialApp(
              title: 'Mock Awesome App',
              theme: ThemeData(
                primarySwatch: Colors.green,
                scaffoldBackgroundColor: Colors.grey[200],
              ),
              home: child),
        );
      },
      child: const ImageListScreen(),
    );
  }
}
