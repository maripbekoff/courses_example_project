part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<RestaurantModel> rests;

  HomeLoaded({required this.rests});
}

class HomeFailed extends HomeState {}
