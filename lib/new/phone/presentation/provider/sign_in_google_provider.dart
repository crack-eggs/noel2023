import 'package:flutter/cupertino.dart';
import 'package:noel/new/phone/data/models/user_model.dart';
import 'package:noel/new/phone/presentation/shared/base_view_model.dart';
import 'package:noel/new/phone/service/user_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../constants.dart';
import '../../domain/usecases/user_usecase.dart';

class SignInGoogleProvider extends BaseViewModel {
  SignInGoogleProvider(super.supabase, super.navigatorService, this.usecase);

  final UserUsecase usecase;

  void onUserSignInGoogle({required Null Function() success}) async {
    await usecase.userRepository.signInGoogle();
  }
}
