import '../../domain/entities/user.dart';

class UserModel extends UserEntity {
  UserModel({
    required String id,
    required String email,
    required String displayName,
    required int score,
    required int hammers,
    required int jackpot,
  }) : super(
    id: id,
    email: email,
    displayName: displayName,
    score: score,
    hammers: hammers,
    jackpot: jackpot,
  );

  // Create a factory constructor to convert from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      displayName: json['displayName'],
      score: json['score'],
      hammers: json['hammers'],
      jackpot: json['jackpot'],
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'score': score,
      'hammers': hammers,
      'jackpot': jackpot,
    };
  }
}
