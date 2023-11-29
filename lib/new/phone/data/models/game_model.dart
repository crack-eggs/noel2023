import '../../domain/entities/game.dart';

class GameModel extends Game {
  GameModel({
    required String id,
    required String uuid,
    required String status,
  }) : super(
    id: id,
    uuid: uuid,
    status: status,
  );

  // Create a factory constructor to convert from JSON
  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      id: json['id'],
      uuid: json['uuid'],
      status: json['status'],
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uuid': uuid,
      'status': status,
    };
  }
}
