import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:courses_example_project/src/common/models/remote/restaurant_model.dart';
import 'package:courses_example_project/src/services/restaurants/restaurant_service.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'restaurant_detail_event.dart';
part 'restaurant_detail_state.dart';

class RestaurantDetailBloc
    extends Bloc<RestaurantDetailEvent, RestaurantDetailState> {
  final RestaurantService restaurantService;

  RestaurantDetailBloc({
    required this.restaurantService,
  }) : super(RestaurantDetailInitial());

  @override
  Stream<RestaurantDetailState> mapEventToState(
    RestaurantDetailEvent event,
  ) async* {
    if (event is InitRestaurantDetail) {
      yield RestaurantDetailLoading();
      try {
        RestaurantModel rest = await restaurantService.getRestaurant(
          id: event.id,
        );
        yield RestaurantDetailLoaded(rest: rest);
      } on DioError catch (e) {
        yield RestaurantDetailFailed();
        throw e;
      } catch (e) {
        yield RestaurantDetailFailed();
        throw e;
      }
    }
  }
}
