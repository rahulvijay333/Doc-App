import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsAuthServiceImpl  {
  SharedPreferences? _sharedPrefs;

  Future<SharedPreferences> getSharedPrefs() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
    return _sharedPrefs!;
  }

  Future<bool> getLoggedInState() async {
    final sharedPrefs = await getSharedPrefs();
    return sharedPrefs.getBool('loggedIn') ?? false;
  }

   Future<String?> getName() async {
    final sharedPrefs = await getSharedPrefs();
    return sharedPrefs.getString('name');
  }



  Future<String?> getRole() async {
    final sharedPrefs = await getSharedPrefs();
    return sharedPrefs.getString('role');
  }

  Future<String?> getToken() async {
    final sharedPrefs = await getSharedPrefs();
    return sharedPrefs.getString('token');
  }

   Future<String?> getId() async {
    final sharedPrefs = await getSharedPrefs();
    return sharedPrefs.getString('id');
  }

  Future<void> saveLoggedInState(bool loggedIn) async {
    final sharedPrefs = await getSharedPrefs();
    await sharedPrefs.setBool('loggedIn', loggedIn);
  }

  Future<void> saveRole(String role) async {
    final sharedPrefs = await getSharedPrefs();
    await sharedPrefs.setString('role', role);
  }

  Future<void> saveToken(String token) async {
    final sharedPrefs = await getSharedPrefs();
    await sharedPrefs.setString('token', token);
  }
  Future<void> saveId(String id) async {
    final sharedPrefs = await getSharedPrefs();
    await sharedPrefs.setString('id', id);
  }

   Future<void> saveName(String name) async {
    final sharedPrefs = await getSharedPrefs();
    await sharedPrefs.setString('name', name);
  }




}
