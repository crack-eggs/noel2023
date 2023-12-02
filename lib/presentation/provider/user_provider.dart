import '../../domain/usecases/user_usecase.dart';
import '../../service/user_service.dart';
import '../shared/base_view_model.dart';

import '../../data/models/topup_history_model.dart';
import '../../enums.dart';
import '../../route.dart';

class UserProvider extends BaseViewModel {
  UserProvider(super.supabase, super.navigatorService, this.userUsecase);

  final UserUsecase userUsecase;

  updateUser() async {
    setState(ViewState.busy);
    print('UserProvider.updateUser');
    await userUsecase.fetch();
    setState(ViewState.idle);

  }

  void onUserTopUp(int number) async {
    print('UserProvider.onUserTopUp');
    setState(ViewState.busy);
    await userUsecase.topup(number);
    await userUsecase.fetch();

    setState(ViewState.idle);
  }

  void onUserStartGame() async {
    setState(ViewState.busy);
    await userUsecase.fetch();
    AppRouter.router.navigateTo(navigatorService.context!, '/mobile-game-play');
    setState(ViewState.idle);
  }
}
