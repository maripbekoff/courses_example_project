import 'package:courses_example_project/src/common/blocs/bloc/auth_bloc.dart';
import 'package:courses_example_project/src/common/dependencies/injection_container.dart';
import 'package:courses_example_project/src/common/hive/hive_box.dart';
import 'package:courses_example_project/src/constants/color_const.dart';
import 'package:courses_example_project/src/constants/theme.dart';
import 'package:courses_example_project/src/routes/router.dart';
import 'package:courses_example_project/src/routes/routing_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  initGetIt();
  await initHive();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Блокируем ориентацию по горизонтали
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    // Задаём прозрачный цвет системному статус бару 
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Color(0xFF),
        systemNavigationBarColor: Color(0xFF),
      ),
    );

    return BlocProvider(
      create: (context) => AuthBloc()..add(AppStart()),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is Authenticated) {
            return _buildApp(MainRoute);
          } else if (state is UnAuthenticated) {
            return _buildApp(AuthRoute);
          }
          return Offstage();
        },
      ),
    );
  }

  CupertinoApp _buildApp(String route) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Courses example',
      theme: CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        barBackgroundColor: AppColors.white,
        textTheme: AppTheme.theme,
      ),
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: route,
    );
  }
}
