import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awesome_app/image_pexel/bloc/image_provider.dart';
import 'package:awesome_app/image_pexel/screens/image_list_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
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
