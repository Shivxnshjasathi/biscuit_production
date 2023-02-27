import 'package:shared_preferences/shared_preferences.dart';

String? userToken = null; 
SharedPreferences? prefs = null;

void GetToken() async {
    prefs = await SharedPreferences.getInstance();
    userToken = prefs!.getString("token");
  }

void SetToken() async {
    print(userToken);
    await prefs!.setString("token",userToken!);
  }
void RemoveToken() async {
    print(userToken);
    await prefs!.remove("token");
  }