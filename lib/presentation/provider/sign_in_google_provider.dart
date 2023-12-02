import 'package:google_sign_in_platform_interface/src/types.dart';

import '../../domain/usecases/user_usecase.dart';
import '../shared/base_view_model.dart';

class SignInGoogleProvider extends BaseViewModel {
  SignInGoogleProvider(super.supabase, super.navigatorService, this.usecase);

  final UserUsecase usecase;

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
}
