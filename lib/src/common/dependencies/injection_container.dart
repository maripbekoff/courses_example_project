import 'package:courses_example_project/src/common/dio/app_dio.dart';
import 'package:courses_example_project/src/services/auth/authorization_service.dart';
import 'package:courses_example_project/src/services/favourites/favourites_service.dart';
import 'package:courses_example_project/src/services/restaurants/restaurant_service.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.I;

initGetIt() {
  // Dio Client
  getIt.registerLazySingleton<AppDio>(() => AppDio());

  // Services
  getIt.registerLazySingleton<AuthorizationService>(
    () => AuthorizationServiceImpl(
      appDio: getIt<AppDio>(),
    ),
  );

  getIt.registerLazySingleton<RestaurantService>(
    () => RestaurantServiceImpl(
      appDio: getIt<AppDio>(),
    ),
  );

  getIt.registerLazySingleton<FavouritesService>(
    () => FavouritesServiceImpl(
      appDio: getIt<AppDio>(),
    ),
  );
}
