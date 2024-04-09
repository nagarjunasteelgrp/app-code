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
    await prefs.setInt('userId', userId);
  }

  Future<int?> getUserIdPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId');
  }

  Future<void> saveUserEmailPrefs(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
  }

  Future<String?> getUserEmailPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  Future<void> saveUserPhoneNoPrefs(String mobile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('mobile', mobile);
  }

  Future<String?> getUserPhoneNoPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('mobile');
  }

  Future<void> saveUserUsernamePrefs(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
  }

  Future<String?> getUserUsernamePrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  Future<void> saveEmpIdPrefs(String empId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('empId', empId);
  }

  Future<String?> getEmpIdPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('empId');
  }

  Future<void> saveRolePrefs(String role) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('role', role);
  }

  Future<String?> getRolePrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('role');
  }


}
