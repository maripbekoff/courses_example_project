import 'package:json_annotation/json_annotation.dart';

part 'tokens_model.g.dart';

@JsonSerializable()
class TokensModel {
  @JsonKey(name: 'accessToken')
  final String? access;
  @JsonKey(name: 'refreshToken')
  final String? refresh;

  TokensModel({
    required this.access,
    required this.refresh,
  });

  factory TokensModel.fromJson(Map<String, dynamic> json) =>_$TokensModelFromJson(json);
  Map<String, dynamic> toJson() => _$TokensModelToJson(this);
}
