import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart'; // Importing generated code for Freezed class
part 'user_model.g.dart'; // Importing generated code for JSON serialization

@freezed
class UserModel with _$UserModel {
  factory UserModel({
    @Default('') String token,
    @Default('') String error,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
