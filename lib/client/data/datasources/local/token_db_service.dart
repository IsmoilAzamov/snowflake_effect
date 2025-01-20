
import '../../../../../main.dart';

class TokenService {
  static Future<void> saveToken(String token) async {
    await box.put('token', token);
    prefs.setString('token', token);
    //update sl() token
  }

  static Future<String?> getToken() async {
    return box.get('token');
  }

  static Future<bool> deleteToken() async {
    try{
      await box.put('token', null);
      prefs.setString('token', '');
      // print('Token deleted');
      return true;
    } catch (e) {
      // print(e);
      return false;
    }
  }

  static Future<String> accessToken() async {
    final token = await getToken();
    return token??'';
  }


  // static Future<String> sessionState() async {
  //   final token = await getToken();
  //   return token?.authorizationAdditionalParameters['session_state']??'null';
  // }
}
