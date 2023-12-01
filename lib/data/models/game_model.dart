
class GameModel {
  final int score;
  final String? email;
  final int? hammersRemain;

  GameModel({
    required this.score,
    this.email,
    this.hammersRemain,
  });

  Map<String, dynamic> toJson() {
    return {
      'score': score,
      'email': email,
      'hammers_remain': hammersRemain,
    };
  }
}
