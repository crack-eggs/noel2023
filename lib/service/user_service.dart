import '../../constants.dart';
import '../data/models/user_model.dart';

class UserService {
  UserModel? _currentUser;

  // Singleton setup
  static final UserService _instance = UserService._internal();

  factory UserService() {
    return _instance;
  }

  UserService._internal() {
    // _loadUserFromPrefs();
  }

  // Getter for the current user
  UserModel? get currentUser => _currentUser;

  // Save user method
  Future<void> saveUser(UserModel user) async{
    _currentUser = user;
   // await _saveUserToPrefs();
    // Add logic to persist user data to storage/database as needed
  }

  // Load user data from SharedPreferences
  // void _loadUserFromPrefs() {
  //   String? userJson = prefs.getString('user');
  //
  //   if (userJson != null) {
  //     print('UserService._loadUserFromPrefs');
  //     _currentUser =
  //         UserModel.fromJson(jsonDecode(userJson) as Map<String, dynamic>);
  //   }
  // }

  // Save user data to SharedPreferences
  Future<void> _saveUserToPrefs() async {
    // await prefs.setString('user', jsonEncode(_currentUser!.toJson()));
  }

  Future<void> fetch() async {
    final result = await supabase
        .from('users')
        .select('*')
        .eq('email', currentUser!.email)
        .execute();
    final List<UserModel> newUser = (result.data as List<dynamic>)
        .map((data) => UserModel.fromJson(data))
        .toList();
    saveUser(newUser.first);
  }
}
