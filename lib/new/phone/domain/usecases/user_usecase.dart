import 'package:noel/new/phone/domain/repositories/user_repository.dart';

import '../../data/models/topup_history_model.dart';

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
