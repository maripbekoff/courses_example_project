part of 'restaurant_detail_bloc.dart';

@immutable
abstract class RestaurantDetailState {}

class RestaurantDetailInitial extends RestaurantDetailState {}

class RestaurantDetailLoading extends RestaurantDetailState {}

class RestaurantDetailLoaded extends RestaurantDetailState {
  final RestaurantModel rest;

  RestaurantDetailLoaded({required this.rest});
}

class RestaurantDetailFailed extends RestaurantDetailState {}
