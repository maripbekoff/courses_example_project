import 'package:json_annotation/json_annotation.dart';

import 'coords_model.dart';
import 'image_model.dart';
import 'schedule_model.dart';

part 'restaurant_model.g.dart';

@JsonSerializable(explicitToJson: true)
class RestaurantModel {
  final int id;
  @JsonKey(name: 'is_favourite')
  final bool isFavourite;
  final String title;
  final String description;
  final ScheduleModel schedule;
  final CoordsModel coords;
  final List<ImageModel> images;

  RestaurantModel({
    required this.id,
    required this.isFavourite,
    required this.title,
    required this.description,
    required this.schedule,
    required this.coords,
    required this.images,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantModelFromJson(json);
  Map<String, dynamic> toJson() => _$RestaurantModelToJson(this);
}
