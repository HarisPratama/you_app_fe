import 'dart:ffi';

import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String message;
  final UserData data;

  const UserModel({
    required this.message,
    required this.data,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      message: json['message'] ?? '',
      data: UserData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  @override
  List<Object?> get props => [message, data];
}

class UserData extends Equatable {
  final String email;
  final String username;
  final String? name;
  final String? birthday;
  final String? horoscope;
  final String? zodiac;
  final int? height;
  final int? weight;
  final List<String> interests;

  const UserData({
    required this.email,
    required this.username,
    this.name,
    this.birthday,
    this.horoscope,
    this.zodiac,
    this.height,
    this.weight,
    required this.interests,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      name: json['name'] ?? '',
      birthday: json['birthday'] ?? '',
      horoscope: json['horoscope'] ?? '',
      zodiac: json['zodiac'] ?? '',
      height: json['height'] ?? 0,
      weight: json['weight'] ?? 0,
      interests: List<String>.from(json['interests'] ?? []),
    );
  }

  @override
  List<Object?> get props => [email, username, name, birthday, horoscope, zodiac, height, weight, interests];
}
