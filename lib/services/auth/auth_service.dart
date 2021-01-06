import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pasar/incls/api_config.dart';
import 'package:pasar/models/auth/login_model.dart';
import 'package:pasar/models/auth/register_model.dart';

class AuthService {
  final _storage = FlutterSecureStorage();

  Future<LoginModel> login(
      {@required String email, @required String password}) async {
    try {
      var req = {
        'email': email,
        'password': password,
      };
      var res = await http.post(
        apiUrl + 'auth/login',
        body: req,
      );
      return LoginModel.fromJson(json.decode(res.body));
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<RegisterModel> register({
    @required String userFullname,
    @required String email,
    @required String phone,
    @required String password,
  }) async {
    try {
      var req = {
        'user_fullname': userFullname,
        'email': email,
        'phone': phone,
        'password': password,
      };
      var res = await http.post(apiUrl + "auth/register", body: req);
      print(res.body);
      return RegisterModel.fromJson(json.decode(res.body));
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String> readUserId() async {
    return await _storage.read(key: 'userId');
  }

  Future<String> readAccessToken() async {
    return await _storage.read(key: 'accesssToken');
  }

  Future<void> presistUserId({String userId}) async {
    _storage.write(key: userId, value: userId);
  }

  Future<void> presistAccsessToken({String accessToken}) async {
    await _storage.write(key: 'accesssToken', value: accessToken);
  }

  Future<void> deleteUserId() async {
    await _storage.delete(key: 'userId');
  }

  Future<void> deleteAccessToken() async {
    await _storage.delete(key: 'accesssToken');
  }
}
