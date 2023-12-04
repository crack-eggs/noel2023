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

  Future<void> topup(int quantity) async {
    return await userRepository.topup(quantity);
  }

  Future<void> reduceHammer() async {
    return await userRepository.reduceHammer();
  }

  Future<void> updateScore(int random) async {
    return await userRepository.updateScore(random);
  }
}
