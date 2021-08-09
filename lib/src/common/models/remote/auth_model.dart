import 'package:courses_example_project/src/common/models/remote/tokens_model.dart';
import 'package:courses_example_project/src/common/models/remote/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AuthModel {
  final TokensModel tokens;
  final UserModel user;

  AuthModel({
    required this.tokens,
    required this.user,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) =>
      _$AuthModelFromJson(json);
  Map<String, dynamic> toJson() => _$AuthModelToJson(this);
}
