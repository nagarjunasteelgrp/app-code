import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefers {

  Future<void> saveTokenToPrefs(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String?> getTokenFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> saveUserIdPrefs(int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', userId);
  }

  Future<int?> getUserIdPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
  }

  Future<void> saveUserEmailPrefs(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_email', token);
  }

  Future<String?> getUserEmailPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_email');
  }

  Future<void> saveUserPhoneNoPrefs(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_phoneNo', token);
  }

  Future<String?> getUserPhoneNoPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_phoneNo');
  }

  Future<void> saveUserUsernamePrefs(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_username', token);
  }

  Future<String?> getUserUsernamePrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_username');
  }

  Future<void> saveEmpIdPrefs(int empId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('empId', empId);
  }

  Future<int?> getEmpIdPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('empId');
  }

  Future<void> saveRolePrefs(int role) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('role', role);
  }

  Future<int?> getRolePrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('role');
  }


}
