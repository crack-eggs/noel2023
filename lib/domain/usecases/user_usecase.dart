
import '../../data/models/topup_history_model.dart';
import '../repositories/user_repository.dart';

class UserUsecase {
  final UserRepository userRepository;

  UserUsecase(this.userRepository);

  Future<void> signInGoogle() async {
    return await userRepository.signInGoogle();
  }

  Future<void> fetch() async {
    return await userRepository.fetchUser();
  }

  Future<void> topup(TopUpHistoryModel model) async {
    return await userRepository.topup(model);
  }
}
