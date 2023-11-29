import 'package:flutter/material.dart';
import 'package:noel/new/phone/service/user_service.dart';
import 'package:provider/provider.dart';

import '../../route.dart';
import '../provider/user_provider.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  void initState() {
    Provider.of<UserProvider>(context, listen: false).updateUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Text(UserService().currentUser!.toJson().toString()),
        ElevatedButton(
            onPressed: () {
              AppRouter.router.navigateTo(context, '/mobile-game-play');
            },
            child: const Text('Start Game'))
      ],
    ));
  }
}
