import 'package:awesome_app/core/bloc/connectivity_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awesome_app/image_pexel/bloc/image_provider.dart';
import 'package:awesome_app/image_pexel/screens/image_list_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  await dotenv.load(fileName: 'main.env');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

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
              create: (context) => ImageProviderBloc()..add(FetchImages()),
            ),
            BlocProvider<ConnectivityBloc>(
              create: (context) => ConnectivityBloc(),
            )
          ],
          child: MaterialApp(
              title: 'Awesome App',
              theme: ThemeData(
                primarySwatch: Colors.purple,
                scaffoldBackgroundColor: Colors.white,
              ),
              home: child),
        );
      },
      child: const ImageListScreen(),
    );
  }
}
