import 'package:bloc/bloc.dart';
import 'package:courses_example_project/src/services/favourites/favourites_service.dart';
import 'package:meta/meta.dart';

part 'favourites_state.dart';

class FavouritesCubit extends Cubit<FavouritesState> {
  FavouritesCubit({
    required this.favouritesService,
  }) : super(FavouritesInitial());

  final FavouritesService favouritesService;

  addFavourite(int id) async {
    emit(FavouritesLoading());
    try {
      await favouritesService.addFavourite(id: id);
      emit(FavouritesLoaded());
    } catch (e) {
      emit(FavouritesFailed());
    }
  }
}
