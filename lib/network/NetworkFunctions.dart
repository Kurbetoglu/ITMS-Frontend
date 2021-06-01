import 'dart:convert';

import 'package:asset_yonet/models/AdminLoginResponse.dart';
import 'package:asset_yonet/models/BaseResponse.dart';
import 'package:asset_yonet/models/GetAllAssetsResponse.dart';
import 'package:asset_yonet/models/GetAllDebitsResponse.dart';
import 'package:asset_yonet/models/GetAssetsByTypeResponse.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NetworkFunctions {
  static String uri = "http://3.138.187.210:5000/api/Admin";
  //static String uri = "http://10.0.3.2:5000/api/Admin";
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
      print(response.statusCode);
      throw Exception("Failed to admin login.");
    }
  }

  static Future<BaseResponse> adminLogoff() async {
    setCookie();
    final response = await http.get(
      Uri.parse(uri + "/AdminLogoff"),
      headers: headers,
    );

    if (response.statusCode == 200) {
      removeSharedPreference("cookie");

      return BaseResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to admin logoff.");
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
      throw Exception("Failed to adding user.");
    }
  }

  static Future<BaseResponse> addAsset(
      String type,
      String name,
      String description,
      int expiryDate,
      String personName,
      String personSurname,
      String email ) async {

    setCookie();
    final response = await http.post(
      Uri.parse(uri + "/AddAsset"),
      headers: headers,
      body: jsonEncode(<String, dynamic>{
        "type": type,
        "name": name,
        "description": description,
        "expiryDate": expiryDate,
        "personName": personName,
        "personSurname": personSurname,
        "email": email,
      }),
    );

    if (response.statusCode == 200) {
      return BaseResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to adding asset.");
    }
  }

  static Future<GetAssetsByTypeResponse> getAssetsByType(int pageNumber, int pageSize, String type) async {
    setCookie();
    final response = await http.post(
      Uri.parse(uri + "/GetAssetsByType"),
      headers: headers,
      body: jsonEncode(<String, dynamic>{
        "pageNumber": pageNumber,
        "pageSize": pageSize,
        "type": type
      }),
    );

    if (response.statusCode == 200) {
      return GetAssetsByTypeResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to fetching assets.");
    }
  }

  static Future<BaseResponse> addDebit(String userEmail, int assetId, String type, String name, int endDate, String cause,) async {
    setCookie();
    final response = await http.post(
      Uri.parse(uri + "/AddDebit"),
      headers: headers,
      body: jsonEncode(<String, dynamic>{
        "userEmail": userEmail,
        "assetId": assetId,
        "type": type,
        "name": name,
        "endDate": endDate,
        "cause": cause,
      }),
    );

    if (response.statusCode == 200) {
      return BaseResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to adding debit.");
    }
  }

  static Future<GetAllAssetsResponse> getAllAssets (int pageNumber, int pageSize) async {
    setCookie();
    final response = await http.post(
      Uri.parse(uri + "/GetAllAssets"),
      headers: headers,
      body: jsonEncode(<String, dynamic>{
        "pageNumber": pageNumber,
        "pageSize": pageSize,
      }),
    );

    if (response.statusCode == 200) {
      return GetAllAssetsResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to fetching assets.");
    }
  }

  static Future<GetAllDebitsResponse> getAllDebits (int pageNumber, int pageSize) async {
    setCookie();
    final response = await http.post(
      Uri.parse(uri + "/GetAllDebits"),
      headers: headers,
      body: jsonEncode(<String, dynamic>{
        "pageNumber": pageNumber,
        "pageSize": pageSize,
      }),
    );

    if (response.statusCode == 200) {
      return GetAllDebitsResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to fetching debits.");
    }
  }

  static Future<BaseResponse> removeDebit (int debitId) async {
    setCookie();
    final response = await http.post(
      Uri.parse(uri + "/RemoveDebit"),
      headers: headers,
      body: jsonEncode(<String, dynamic>{
        "debitId": debitId,
      }),
    );

    if (response.statusCode == 200) {
      return BaseResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to removing debit.");
    }
  }

  void updateCookie(http.Response response) {
    String rawCookie = response.headers["set-cookie"];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      headers["cookie"] = (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }
  static void saveCookie(http.Response response) async {
    String rawCookie = response.headers["set-cookie"];
    String cookie;
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      cookie = (index == -1) ? rawCookie : rawCookie.substring(0, index);
      headers["cookie"] = cookie;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("cookie", cookie);
  }

  static void setCookie() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cookie = prefs.getString("cookie");
    headers["cookie"] = cookie;
  }

  static void removeSharedPreference(String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}

