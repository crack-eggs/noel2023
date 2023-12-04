class UserEntity {
  final String email;
  final String displayName;
  final int score;
  final int hammers;
  final int jackpot;
  final String avatar;

  UserEntity({
    required this.email,
    required this.displayName,
    required this.score,
    required this.hammers,
    required this.jackpot,
    required this.avatar,
  });
}
