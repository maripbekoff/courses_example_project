import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:courses_example_project/src/common/models/remote/restaurant_model.dart';
import 'package:courses_example_project/src/services/restaurants/restaurant_service.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final RestaurantService restaurantService;

  MapBloc({
    required this.restaurantService,
  }) : super(MapInitial());

  @override
  Stream<MapState> mapEventToState(
    MapEvent event,
  ) async* {
    yield MapLoading();
    try {
      List<RestaurantModel> rests = await restaurantService.getRestaurants(
        limit: 100,
      );
      yield MapLoaded(rests: rests);
    } on DioError catch (e) {
      yield MapFailed();
      throw e;
    } catch (e) {
      yield MapFailed();
      throw e;
    }
  }
}
