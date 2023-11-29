import 'package:flutter/cupertino.dart';
import 'package:noel/new/phone/data/models/user_model.dart';
import 'package:noel/new/phone/service/user_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../constants.dart';

class SignInGoogleProvider extends ChangeNotifier {
  final SupabaseClient supabaseClient;

  SignInGoogleProvider(this.supabaseClient);

  Future<void> onUserSignInGoogle({required Function() success}) async {
    final google = await googleSignIn.signIn();
    if (google != null) {
      print('google: ${google.toString()}');
      final user = UserModel(
          email: google.email, displayName: google.displayName ?? google.email);
      await supabase.from('users').insert(user.toJson());

      UserService().saveUser(user);
      success();
    }
  }
}
