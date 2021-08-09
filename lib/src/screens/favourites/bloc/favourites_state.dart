part of 'favourites_bloc.dart';

@immutable
abstract class FavouritesState {}

class FavouritesInitial extends FavouritesState {}

class FavouritesLoading extends FavouritesState {}

class FavouritesLoaded extends FavouritesState {
  final List<RestaurantModel> rests;

  FavouritesLoaded({required this.rests});
}

class FavouritesFailed extends FavouritesState {}
