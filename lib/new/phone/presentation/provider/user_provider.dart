import 'package:flutter/material.dart';
import 'package:noel/new/phone/service/user_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  final SupabaseClient supabaseClient;

  UserProvider(this.supabaseClient);

  updateUser() async {
    print('UserProvider.updateUser');
    print('UserService().currentUser!.email: ${UserService().currentUser!.email}');
    final result = await supabaseClient
        .from('users')
        .select('*')
        .eq('email', UserService().currentUser!.email)
        .execute();
    if((result.data as List).isNotEmpty == true) {
      print('test: ${(result.data[0])}');
      final newUser = UserModel.fromJson(result.data[0]);
      UserService().saveUser(newUser);
    }
  }
}
