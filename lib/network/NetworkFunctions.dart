import 'dart:convert';

import 'package:asset_yonet/models/AdminLoginResponse.dart';
import 'package:asset_yonet/models/BaseResponse.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NetworkFunctions {
  static String uri = "http://3.138.187.210:5000/api/Admin";
  static Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8",
  };
  static Future<AdminLoginResponse> adminLogin(String email, String password) async {
    final response = await http.post(
      Uri.parse(uri + "/AdminLogin"),
      headers: headers,
      body: jsonEncode(<String, String>{
        "email": email,
        "password": password
      }),
    );

    if (response.statusCode == 200) {
      var object = AdminLoginResponse.fromJson(jsonDecode(response.body));
      if(object.success){
        saveCookie(response);
      }
      return object;
    } else {
      throw Exception('Failed to admin login.');
    }
  }

  static Future<BaseResponse> addUser(String name, String surname, String email, String telephoneNumber) async {
    setCookie();
    final response = await http.post(
      Uri.parse(uri + "/AddUser"),
      headers: headers,
      body: jsonEncode(<String, String>{
        "name": name,
        "surname": surname,
        "email": email,
        "telephoneNumber": telephoneNumber,
      }),
    );

    if (response.statusCode == 200) {
      return BaseResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to admin login.');
    }
  }


  void updateCookie(http.Response response) {
    String rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      headers['cookie'] = (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }
  static void saveCookie(http.Response response) async {
    String rawCookie = response.headers['set-cookie'];
    String cookie;
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      cookie = (index == -1) ? rawCookie : rawCookie.substring(0, index);
      headers['cookie'] = cookie;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("cookie", cookie);
  }

  static void setCookie() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cookie = prefs.getString("cookie");
    headers['cookie'] = cookie;
  }
}

