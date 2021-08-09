import 'package:json_annotation/json_annotation.dart';

part 'coords_model.g.dart';

@JsonSerializable()
class CoordsModel {
  final int id;
  final double longitude;
  final double latitude;
  @JsonKey(name: 'address_name')
  final String addressName;

  CoordsModel({
    required this.addressName,
    required this.id,
    required this.latitude,
    required this.longitude,
  });

  factory CoordsModel.fromJson(Map<String, dynamic> json) =>
      _$CoordsModelFromJson(json);
  Map<String, dynamic> toJson() => _$CoordsModelToJson(this);
}
