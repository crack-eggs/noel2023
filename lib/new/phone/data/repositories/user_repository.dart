import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../constants.dart';
import '../../domain/repositories/user_repository.dart';
import '../../service/user_service.dart';
import '../models/topup_history_model.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final SupabaseClient supabaseClient;

  UserRepositoryImpl(this.supabaseClient);

  @override
  Future<void> signInGoogle() async {
    final googleUser = await googleSignIn.signInSilently();
    final googleAuth = await googleUser!.authentication;
    final idToken = googleAuth.idToken;

    if (idToken == null) {
      throw 'No ID Token found.';
    }

    final result = await supabaseClient.auth.signInWithIdToken(
      provider: Provider.google,
      idToken: idToken,
    );

    print('session: ${result.session?.toJson()}');

    print('user: ${result.user?.toJson()}');
    final response = await supabaseClient
        .from('users')
        .select('*')
        .order('score', ascending: false)
        .limit(10)
        .execute();

    print('response: ${response.data}');

    // final user = UserModel(
    //     email: googleUser.email,
    //     displayName: googleUser.displayName ?? googleUser.email);
    // await createUser(user);
    // await UserService().saveUser(user);
  }

  @override
  Future<void> createUser(UserModel user) async {
    try {
      await supabase.from('users').insert(user.toJson());
    } catch (e) {
      print('error: ${e.toString()}');
    }
  }

  @override
  Future<void> updateHammers(int hammers) {
    // TODO: implement updateHammers
    throw UnimplementedError();
  }

  @override
  Future<void> updateScore(int score) {
    // TODO: implement updateScore
    throw UnimplementedError();
  }

  @override
  Future<void> fetchUser() async {
    await UserService().fetch();
  }

  @override
  Future<void> topup(TopUpHistoryModel model) async {
    await Future.wait([
      supabase.from('topup_history').insert(model.toJson()).execute(),
      supabase
          .from('users')
          .update(
              {'hammers': UserService().currentUser!.hammers + model.quantity})
          .eq('email', UserService().currentUser!.email)
          .execute()
    ]);
    await fetchUser();
  }
}
