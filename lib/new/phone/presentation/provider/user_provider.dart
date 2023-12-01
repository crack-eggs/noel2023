import 'package:noel/new/phone/domain/usecases/user_usecase.dart';
import 'package:noel/new/phone/presentation/shared/base_view_model.dart';
import 'package:noel/new/phone/service/user_service.dart';

import '../../data/models/topup_history_model.dart';
import '../../enums.dart';
import '../../route.dart';

class UserProvider extends BaseViewModel {
  UserProvider(super.supabase, super.navigatorService, this.userUsecase);

  final UserUsecase userUsecase;

  updateUser() async {
    await userUsecase.fetch();
  }

  void onUserTopUp(int number) async {
    setState(ViewState.busy);

    TopUpHistoryModel values = TopUpHistoryModel(
      email: UserService().currentUser!.email,
      hammersBefore: UserService().currentUser!.hammers,
      quantity: number,
    );

    await userUsecase.topup(values);
    setState(ViewState.idle);
  }

  void onUserStartGame() async {
    setState(ViewState.busy);
    await userUsecase.fetch();
    AppRouter.router.navigateTo(navigatorService.context!, '/mobile-game-play');
    setState(ViewState.idle);
  }
}
