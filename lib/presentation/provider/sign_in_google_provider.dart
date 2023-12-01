import '../../domain/usecases/user_usecase.dart';
import '../shared/base_view_model.dart';

class SignInGoogleProvider extends BaseViewModel {
  SignInGoogleProvider(super.supabase, super.navigatorService, this.usecase);

  final UserUsecase usecase;

  void onUserSignInGoogle({required Null Function() success}) async {
    await usecase.userRepository.signInGoogle();
  }
}
