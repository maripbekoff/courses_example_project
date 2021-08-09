import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:courses_example_project/src/common/models/remote/restaurant_model.dart';
import 'package:courses_example_project/src/services/restaurants/restaurant_service.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required this.restaurantService,
  }) : super(HomeInitial());

  RestaurantService restaurantService;

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is InitHome) {
      yield HomeLoading();
      try {
        List<RestaurantModel> rests = await restaurantService.getRestaurants();
        yield HomeLoaded(rests: rests);
      } on DioError catch (e) {
        yield HomeFailed();
        throw e;
      } catch (e) {
        yield HomeFailed();
        throw e;
      }
    }
  }
}
