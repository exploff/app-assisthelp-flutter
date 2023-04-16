import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:app_assisthelp/model/auth.model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class AuthRepository {
  static String mainUrl = "10.0.2.2:8080";
  var signInUrl = '/token';
  var signUpUrl = '/signup';

  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<bool> hasToken() async {
    var token = await storage.read(key: 'token');
    var refreshToken = await storage.read(key: 'refresh_token');
    return token != null && refreshToken != null;
  }

  Future<void> persisteToken(String token, String refreshToken) async {
    await storage.write(key: 'token', value: token);
    await storage.write(key: 'refresh_token', value: refreshToken);
  }

  Future<void> deleteToken() async {
    storage.delete(key: 'token');
    storage.delete(key: 'refresh_token');
    storage.deleteAll();
  }

  Future<Authentication> refreshToken() async {
    var refreshToken = await storage.read(key: 'refresh_token');

    var data = {
      'withRefreshToken': "true",
      'grantType': 'refresh_token',
      'refreshToken': refreshToken
    };

    var url = Uri.http(mainUrl, signInUrl, data);

    var response = await http.post(url);
    
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
      var authentication = Authentication.fromJson(jsonResponse);
      await persisteToken(authentication.token!, authentication.refreshToken!);
      return authentication;
    }
    throw Exception('Erreur de connexion');
  }

  Future<Authentication> login(String username, password) async {
    var data = {
      'username': username,
      'password': password,
      'withRefreshToken': "true",
      'grantType': 'password'
    };
    var url = Uri.http(mainUrl, signInUrl, data);
    var response = await http.post(url);
    
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
      return Authentication.fromJson(jsonResponse);
    }
    throw Exception('Erreur de connexion');
  }

  Future<Authentication> register(String username, String email, String password) async {
    var data = {
      'username': username,
      'password': password,
      'emailAddress': email
    };

    //var url = Uri.http(mainUrl, signUpUrl);
    //var response = await http.post(url, headers: {"Content-Type": "application/json"}, body: convert.jsonEncode(data));

    var url = Uri.http(mainUrl, signUpUrl, data);
    var response = await http.post(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
      return Authentication.fromJson(jsonResponse);
    }

    var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;

    var message = jsonResponse['error'] | "Erreur inconnue";

    throw Exception(message);
  }
}
