import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipes/data/env/env.dart';
import 'package:recipes/data/storage/secure_storage.dart';
import 'package:recipes/domain/models/response/response_login.dart';


class AuthServices {
  Future<ResponseLogin> login(String email, String password) async {

    final resp = await http.post(Uri.parse('${Environment.urlApi}/auth-login'),
      headers: { 'Accept': 'application/json' },
      body: {
        'email' : email,
        'password': password
      }
    );
    return ResponseLogin.fromJson( jsonDecode( resp.body ));
  }
  Future<ResponseLogin> renewLogin() async {

    final token = await secureStorage.readToken();

    final resp = await http.get(Uri.parse('${Environment.urlApi}/auth/renew-login'),
      headers: { 'Accept': 'application/json', 'xxx-token' : token! }
    );
    return ResponseLogin.fromJson( jsonDecode( resp.body ));
  }
}

final authServices = AuthServices();