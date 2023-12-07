import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';
import 'package:noel/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/repositories/user_repository.dart';
import '../../service/user_service.dart';
import '../../utils/cryto.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final SupabaseClient supabaseClient;

  UserRepositoryImpl(this.supabaseClient);

  @override
  Future<void> signInGoogle({GoogleSignInUserData? userData}) async {
    UserService().saveUser(UserModel(
        email: userData!.email,
        displayName: userData.displayName!,
        avatar: userData.photoUrl ?? ''));
    try {
      await createUser(UserModel(
          email: userData.email,
          displayName: userData.displayName!,
          avatar: userData.photoUrl ?? ''));
    } catch (e) {
      print('error: ${e.toString()}');
    } finally {
      await fetchUser();
    }
  }

  @override
  Future<void> createUser(UserModel user) async {
    print('UserRepositoryImpl.createUser');
    try {
      await dio.post(
        '/user',
        queryParameters: {
          'code': encryptBlowfish(),
        },
        data: user.toJson(),
      );
    } catch (e) {
      print('error: ${e.toString()}');
    }
  }

  @override
  Future<void> updateHammers(int quantity) async {
    try {
      await dio.patch('/user', queryParameters: {
        'code': encryptBlowfish(),
        'email': UserService().currentUser!.email,
      }, data: {
        'hammers': UserService().currentUser!.hammers + quantity,
      });
    } catch (e) {
      print('error: ${e.toString()}');
    }
  }

  @override
  Future<void> updateScore(int score) async {
    print('UserRepositoryImpl.updateScore');
    try {
      await dio.patch('/user/score', queryParameters: {
        'code': encryptBlowfish(),
        'email': UserService().currentUser!.email,
      }, data: {
        'score': UserService().currentUser!.score + score,
        'hammers': UserService().currentUser!.hammers,
      });
    } catch (e) {
      print('error: ${e.toString()}');
    }
  }

  @override
  Future<void> fetchUser() async {
    print('UserRepositoryImpl.fetchUser');
    final result = await dio.get('/user', queryParameters: {
      'code': encryptBlowfish(),
      'email': UserService().currentUser!.email,
    });

    final List<UserModel> newUser = (result.data as List<dynamic>)
        .map((data) => UserModel.fromJson(data))
        .toList();

    await UserService().fetch(newUser);
  }

  @override
  Future<void> topup(int quantity) async {
    print('UserRepositoryImpl.topup');
    try {
      await dio.patch('/user/topup', queryParameters: {
        'code': encryptBlowfish(),
        'email': UserService().currentUser!.email,
      }, data: {
        'email': UserService().currentUser!.email,
        'quantity': quantity,
      });
    } catch (e) {
      print('error: ${e.toString()}');
    }
  }

  @override
  Future<void> reduceHammer() async {
    try {
      await dio.patch('/user', queryParameters: {
        'code': encryptBlowfish(),
        'email': UserService().currentUser!.email,
      }, data: {
        'hammers': UserService().currentUser!.hammers - 1,
      });
    } catch (e) {
      print('error: ${e.toString()}');
    }
  }
}
