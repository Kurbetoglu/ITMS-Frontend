import 'dart:convert';
import 'dart:core';

import 'package:asset_yonet/DTO/AdminLoginResponse.dart';
import 'package:asset_yonet/DTO/BaseResponse.dart';
import 'package:asset_yonet/DTO/GetAllAssetsResponse.dart';
import 'package:asset_yonet/DTO/GetAllDebitsResponse.dart';
import 'package:asset_yonet/DTO/GetAllUsersResponse.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NetworkFunctions {
  static final String ip = "3.138.187.210";
  static final String port = "5000";
  static final String uri = "http://" + ip + ":" + port + "/api/Admin";
  static Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8",
  };

  static final int maxDataPerPage = 10;

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
      String personEmail) async {
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
        "personEmail": personEmail,
      }),
    );

    if (response.statusCode == 200) {
      return BaseResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to adding asset.");
    }
  }

  static Future<BaseResponse> addDebit(String userEmail, int assetId, int endDate, String cause) async {
    setCookie();
    final response = await http.post(
      Uri.parse(uri + "/AddDebit"),
      headers: headers,
      body: jsonEncode(<String, dynamic>{
        "userEmail": userEmail,
        "assetId": assetId,
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

  static Future<BaseResponse> removeUser (int userId) async {
    setCookie();
    final response = await http.post(
      Uri.parse(uri + "/RemoveUser"),
      headers: headers,
      body: jsonEncode(<String, dynamic>{
        "userId": userId,
      }),
    );

    if (response.statusCode == 200) {
      return BaseResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to removing user.");
    }
  }

  static Future<BaseResponse> removeAsset (int assetId) async {
    setCookie();
    final response = await http.post(
      Uri.parse(uri + "/RemoveAsset"),
      headers: headers,
      body: jsonEncode(<String, dynamic>{
        "assetId": assetId,
      }),
    );

    if (response.statusCode == 200) {
      return BaseResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to removing debit.");
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

  static Future<BaseResponse> updateUser(int userId, String name, String surname, String email, String telephoneNumber) async {
    setCookie();
    final response = await http.post(
      Uri.parse(uri + "/UpdateUser"),
      headers: headers,
      body: jsonEncode(<String, dynamic>{
        "userId": userId,
        "name": name,
        "surname": surname,
        "email": email,
        "telephoneNumber": telephoneNumber,
      }),
    );

    if (response.statusCode == 200) {
      return BaseResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to updating user.");
    }
  }

  static Future<BaseResponse> updateAsset(
      int assetId,
      String type,
      String name,
      String description,
      int expiryDate,
      String personName,
      String personSurname,
      String personEmail,
      bool isAssigned) async {
    setCookie();
    final response = await http.post(
      Uri.parse(uri + "/UpdateAsset"),
      headers: headers,
      body: jsonEncode(<String, dynamic>{
        "assetId": assetId,
        "type": type,
        "name": name,
        "description": description,
        "expiryDate": expiryDate,
        "personName": personName,
        "personSurname": personSurname,
        "personEmail": personEmail,
        "isAssigned": isAssigned,
      }),
    );

    if (response.statusCode == 200) {
      return BaseResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to updating asset.");
    }
  }

  static Future<BaseResponse> updateDebit(int debitId, int assetId, int endDate, bool isDelivered) async {
    setCookie();
    final response = await http.post(
      Uri.parse(uri + "/UpdateDebit"),
      headers: headers,
      body: jsonEncode(<String, dynamic>{
        "debitId": debitId,
        "assetId": assetId,
        "endDate": endDate,
        "isDelivered": isDelivered,
      }),
    );

    if (response.statusCode == 200) {
      return BaseResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to updating debit.");
    }
  }

  static Future<GetAllUsersResponse> getAllUsers (String searchQuery, int pageNumber, int pageSize) async {
    setCookie();
    final response = await http.post(
      Uri.parse(uri + "/GetAllUsers"),
      headers: headers,
      body: jsonEncode(<String, dynamic>{
        "searchQuery": searchQuery,
        "pageNumber": pageNumber,
        "pageSize": pageSize,
      }),
    );

    if (response.statusCode == 200) {
      return GetAllUsersResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to fetching users.");
    }
  }

  static Future<GetAllAssetsResponse> getAllAssets (
      String searchQuery,
      int pageNumber,
      int pageSize,
      String filterByType,
      String filterByIsAssigned,
      String sortByName) async {
    setCookie();
    final response = await http.post(
      Uri.parse(uri + "/GetAllAssets"),
      headers: headers,
      body: jsonEncode(<String, dynamic>{
        "searchQuery": searchQuery,
        "pageNumber": pageNumber,
        "pageSize": pageSize,
        "filterByType": filterByType,
        "filterByIsAssigned": filterByIsAssigned,
        "sortByName": sortByName,
      }),
    );

    if (response.statusCode == 200) {
      return GetAllAssetsResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to fetching assets.");
    }
  }

  static Future<GetAllDebitsResponse> getAllDebits (
      String searchQuery,
      int pageNumber,
      int pageSize,
      String filterByType,
      String filterByIsDelivered,
      String sortByAssetName) async {
    setCookie();
    final response = await http.post(
      Uri.parse(uri + "/GetAllDebits"),
      headers: headers,
      body: jsonEncode(<String, dynamic>{
        "searchQuery": searchQuery,
        "pageNumber": pageNumber,
        "pageSize": pageSize,
        "filterByType": filterByType,
        "filterByIsDelivered": filterByIsDelivered,
        "sortByAssetName": sortByAssetName,
      }),
    );

    if (response.statusCode == 200) {
      return GetAllDebitsResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to fetching debits.");
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

