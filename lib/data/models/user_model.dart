import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required String id,
    required String email,
    required String username,
    String? profileImage,
    String? horoscope,
    String? zodiac,
    int? age,
    String? gender,
  }) : super(
          id: id,
          email: email,
          username: username,
          profileImage: profileImage,
          horoscope: horoscope,
          zodiac: zodiac,
          age: age,
          gender: gender,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      profileImage: json['profile_image'],
      horoscope: json['horoscope'],
      zodiac: json['zodiac'],
      age: json['age'],
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'profile_image': profileImage,
      'horoscope': horoscope,
      'zodiac': zodiac,
      'age': age,
      'gender': gender,
    };
  }
}