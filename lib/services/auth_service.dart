import 'dart:convert';

import 'package:http/http.dart';

class AuthService {
  static final AuthService instance = AuthService._internal();

  factory AuthService() {
    return instance;
  }
  AuthService._internal();

  String url = "https://bsctapi.qurinomsolutions.com/api/";

  Future<String?> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      var response = await post(Uri.parse("${url}auth/login/email"),
          body: {"email": email, "password": password});

      final data = jsonDecode(response.body);
      var token = data["token"];
      return token;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String?> loginWithMobileNumber({
    required String number,
  }) async {
    try {
      var response = await post(Uri.parse("${url}auth/login/phone"),
          body: {"phone": "+91$number"});

      final result = await jsonDecode(response.body);
      var data = result["data"];
      var userId = data["userId"];
      return userId;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String?> verifyOTP({
    required String otp,
    required String userId,
  }) async {
    try {
      var response = await post(Uri.parse("${url}auth/verifyOtp"), body: {
        "otp": otp.trim(),
        "userId": userId.trim(),
      });

      final data = jsonDecode(response.body);

      print("OTP sent : $otp");
      print("UserID sent : $userId");
      print(data.toString());
      var token = data["token"];
      return token;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String?> ResisterUser({
    required String name,
    required String email,
    required String password,
    required String mobileNumber,
    required String dob,
    required String gender,
  }) async {
    try {
      var response = await post(Uri.parse("${url}auth/register"), body: {
        "name": name,
        "email": email,
        "password": password,
        "phone": "+91" + mobileNumber,
        "dob": dob,
        "gender": gender,
      });
      final result = await jsonDecode(response.body);
      var data = result["data"];
      var userId = data["userId"];
      return userId;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String?> GetUserData({required String token}) async {
    try {
      var header = {"token": "Bearer $token"};
      var response = await get(Uri.parse("${url}user/info"), headers: header);
      final data = jsonDecode(response.body);
      print(data);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
