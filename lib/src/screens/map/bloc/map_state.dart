part of 'map_bloc.dart';

@immutable
abstract class MapState {}

class MapInitial extends MapState {}

class MapLoading extends MapState {}

class MapLoaded extends MapState {
  final List<RestaurantModel> rests;

  MapLoaded({required this.rests});
}

class MapFailed extends MapState {}
