import 'package:bloc/bloc.dart';
import 'package:courses_example_project/src/common/models/remote/restaurant_model.dart';
import 'package:courses_example_project/src/services/restaurants/restaurant_service.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final RestaurantService restaurantService;

  HomeBloc({
    required this.restaurantService,
  }) : super(HomeInitial()) {
    on<InitHome>((event, emit) async {
      emit(HomeLoading());
      try {
        List<RestaurantModel> rests = await restaurantService.getRestaurants(
          limit: 100,
        );
        emit(HomeLoaded(rests: rests.reversed.toList()));
      } on DioError catch (e) {
        emit(HomeFailed());
        throw e;
      } catch (e) {
        emit(HomeFailed());
        throw e;
      }
    });
  }
}
