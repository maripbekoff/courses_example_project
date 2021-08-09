import 'package:courses_example_project/src/common/dependencies/injection_container.dart';
import 'package:courses_example_project/src/common/models/local/restaurant_detail_screen_args.dart';
import 'package:courses_example_project/src/routes/routing_const.dart';
import 'package:courses_example_project/src/screens/auth/auth_screen.dart';
import 'package:courses_example_project/src/screens/auth/bloc/log_in_bloc.dart';
import 'package:courses_example_project/src/screens/main/main_screen.dart';
import 'package:courses_example_project/src/screens/register/bloc/register_bloc.dart';
import 'package:courses_example_project/src/screens/register/register_screen.dart';
import 'package:courses_example_project/src/screens/restaurant_detail/bloc/restaurant_detail_bloc.dart';
import 'package:courses_example_project/src/screens/restaurant_detail/restaurant_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AuthRoute:
        return CupertinoPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => LogInBloc(
              authorizationService: getIt(),
            ),
            child: AuthScreen(),
          ),
        );
      case RegisterRoute:
        return CupertinoPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => RegisterBloc(
              authorizationService: getIt(),
            ),
            child: RegisterScreen(),
          ),
        );
      case MainRoute:
        return CupertinoPageRoute(
          builder: (context) => MainScreen(),
        );
      case RestaurantDetailRoute:
        final RestaurantDetailScreenArgs args =
            routeSettings.arguments as RestaurantDetailScreenArgs;

        return CupertinoPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => RestaurantDetailBloc(
              restaurantService: getIt(),
            )..add(InitRestaurantDetail(id: args.id)),
            child: RestaurantDetailScreen(),
          ),
        );
      default:
        return CupertinoPageRoute(
          builder: (context) => AuthScreen(),
        );
    }
  }
}
