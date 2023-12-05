import 'package:flutter/material.dart';
import 'package:noel/enums.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import '../../constants.dart';
import '../../data/models/user_model.dart';
import '../../domain/usecases/leader_board_usecase.dart';
import '../shared/base_view_model.dart';

class WebHomeProvider extends BaseViewModel {
  final LeaderBoardUsecase usecase;

  List<UserModel>? _leaderboard;

  WebHomeProvider(super.supabase, super.navigatorService, this.usecase);

  List<UserModel>? get leaderboard => _leaderboard;

  bool isLoaded = false;

  static const double btnLargeSize = 127;
  static const double btnSmallSize = 110;
  double btnSize = btnLargeSize;

  String _uuid = '';

  String getUUID() {
    _uuid = const Uuid().v4();
    print('_uuid: $_uuid');
    return _uuid;
  }

  Future<void> fetchLeaderboard() async {
    setState(ViewState.busy);
    try {
      _leaderboard = await usecase.call();
    } catch (e) {
      print('Error fetching leaderboard: $e');
    }
    setState(ViewState.idle);
  }

  void loaded() {
    isLoaded = true;
    setState(ViewState.idle);
  }

  void changeSizeButton(double size) {
    btnSize = size;
    setState(ViewState.idle);
  }

  void init() {
    fetchLeaderboard();
    _watch();
  }

  _watch() {
    startChannel.on(
        RealtimeListenTypes.broadcast,
        ChannelFilter(
          event: EventType.start.name,
        ), (payload, [ref]) {

      Navigator.maybePop(navigatorService.context!);

      Navigator.popAndPushNamed(navigatorService.context!, '/web-game-play');
    });
  }
}
