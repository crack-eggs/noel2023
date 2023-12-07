
class Settings {
  final int id;
  final DateTime createdAt;
  final int jackpot;

  Settings({
    required this.id,
    required this.createdAt,
    required this.jackpot,
  });

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      id: json['id'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      jackpot: json['jackpot'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'jackpot': jackpot,
    };
  }
}
