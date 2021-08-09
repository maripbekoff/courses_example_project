part of 'restaurant_detail_bloc.dart';

@immutable
abstract class RestaurantDetailEvent {}

class InitRestaurantDetail extends RestaurantDetailEvent {
  final int id;

  InitRestaurantDetail({required this.id});
}
