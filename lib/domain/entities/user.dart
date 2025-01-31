import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String username;
  final String? profileImage;
  final String? horoscope;
  final String? zodiac;
  final int? age;
  final String? gender;

  const User({
    required this.id,
    required this.email,
    required this.username,
    this.profileImage,
    this.horoscope,
    this.zodiac,
    this.age,
    this.gender,
  });

  @override
  List<Object?> get props => [
        id,
        email,
        username,
        profileImage,
        horoscope,
        zodiac,
        age,
        gender,
      ];
}