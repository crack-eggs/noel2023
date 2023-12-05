import 'dart:async';

import 'package:flutter/material.dart';
import 'package:noel/enums.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import '../../constants.dart';
import '../../data/models/user_model.dart';
import '../../domain/usecases/leader_board_usecase.dart';
import '../../service/event_in_app.dart';
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

  StreamSubscription? _sub;

  Timer? _timer;

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
    _timer ??= Timer.periodic(const Duration(seconds: 5), (timer) {
      fetchLeaderboard();
    });
  }

  watch({required Function onEvent}) {
    _sub ??= EventInApp().controller.stream.listen((event) {
      if (event.eventType == EventType.start) {
        onEvent();
      }
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}
