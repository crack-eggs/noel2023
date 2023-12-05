import 'package:google_sign_in_platform_interface/src/types.dart';
import 'package:noel/enums.dart';
import 'package:noel/service/user_service.dart';

import '../../domain/usecases/game_usecase.dart';
import '../../domain/usecases/user_usecase.dart';
import '../shared/base_view_model.dart';

class SignInGoogleProvider extends BaseViewModel {
  SignInGoogleProvider(
      super.supabase, super.navigatorService, this.usecase, this.gameUsecase);

  final UserUsecase usecase;
  final GameUsecase gameUsecase;

  Future<void> onUserSignInGoogle(
      {required Function() success, GoogleSignInUserData? userData}) async {
    try {
      await usecase.userRepository.signInGoogle(userData: userData);
      success();
    } catch (e) {
      print('SignInGoogleProvider.onUserSignInGoogle');
      print(e);
    }
  }

  void init(String matchId, Function onSuccess, Function onFailure) async {
    setState(ViewState.busy);
    try {
      await gameUsecase.createMatch(id: matchId);
    } catch (e) {
      onFailure();
      return;
    }
    if (UserService().currentUser != null) {
      onSuccess();
    }
    setState(ViewState.idle);
  }
}
