import 'package:noel/enums.dart';
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
}
