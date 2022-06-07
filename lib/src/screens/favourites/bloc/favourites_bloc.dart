import 'package:bloc/bloc.dart';
import 'package:courses_example_project/src/common/models/remote/restaurant_model.dart';
import 'package:courses_example_project/src/services/favourites/favourites_service.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  final FavouritesService favouriteService;

  FavouritesBloc({
    required this.favouriteService,
  }) : super(FavouritesInitial()) {
    on<InitFavourites>((event, emit) async {
      emit(FavouritesLoading());
      try {
        List<RestaurantModel> rests = await favouriteService.getFavourites();
        emit(FavouritesLoaded(rests: rests));
      } on DioError catch (e) {
        emit(FavouritesFailed());
        throw e;
      } catch (e) {
        emit(FavouritesFailed());
        throw e;
      }
    });
  }
}
