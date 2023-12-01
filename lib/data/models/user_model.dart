import '../../domain/entities/user.dart';

class UserModel extends UserEntity {
  UserModel({
    required String email,
    required String displayName,
    int score = 0,
    int hammers = 1,
    int jackpot = 0,
  }) : super(
          email: email,
          displayName: displayName,
          score: score,
          hammers: hammers,
          jackpot: jackpot,
        );

  // Create a factory constructor to convert from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      displayName: json['display_name'],
      score: json['score'] ?? 0,
      hammers: json['hammers'] ?? 1,
      jackpot: json['jackpot'] ?? 0,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'display_name': displayName,
      'score': score,
      'hammers': hammers,
      'jackpot': jackpot,
    };
  }
}
