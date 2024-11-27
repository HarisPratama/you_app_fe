import 'package:equatable/equatable.dart';

class AuthLoginModel extends Equatable {
  final String message;
  final String accessToken;

  const AuthLoginModel({
    required this.message,
    required this.accessToken,
  });

  factory AuthLoginModel.fromJson(Map<String, dynamic> json) {
    return AuthLoginModel(
      message: json['message'] ?? '',
      accessToken: json['access_token'] ?? '',
    );
  }

  @override
  List<Object?> get props => [message, accessToken];
}
class AuthRegisterModel extends Equatable {
  final String message;

  const AuthRegisterModel({
    required this.message,
  });

  factory AuthRegisterModel.fromJson(Map<String, dynamic> json) {
    return AuthRegisterModel(
      message: json['message'] ?? '',
    );
  }

  @override
  List<Object?> get props => [message];
}
