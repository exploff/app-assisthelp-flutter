import 'dart:io';

import 'package:app_assisthelp/model/user.model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:app_assisthelp/model/auth.model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../exception/unauthorized.exception.dart';

class UserRepository {
  static String mainUrl = "10.0.2.2:8080";
  var currentUserUrl = '/account/current-user';

  final FlutterSecureStorage storage = FlutterSecureStorage();

//TODO : TESTER LE COUP DE LA REFRESH TOKEN


  Future<User> getCurrentUser() async {
    
    var url = Uri.http(mainUrl, currentUserUrl);

    var token = await storage.read(key: 'token');

    var response = await http.get(
      url, 
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    ).timeout(const Duration(seconds: 15), onTimeout: () {
      throw Exception('Erreur de connexion');
    });
    
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
      return User.fromJson(jsonResponse['data']);
    }

    print("ERROR " + response.statusCode.toString());
    if (response.statusCode == 401) {
      throw UnauthorizedException(response.statusCode.toString() + " : " + response.body.toString());
    }

    throw Exception('Erreur récupération utilisateur ' + response.statusCode.toString());
  }

  Future<User> updateCurrentUser(User user) async {

    print(user.toJson());
    var body = convert.jsonEncode(user.toJson());

    var url = Uri.http(mainUrl, currentUserUrl);

    var token = await storage.read(key: 'token');

    var response = await http.put(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
      return User.fromJson(jsonResponse['data']);
    }

    print("ERROR " + response.statusCode.toString());
    if (response.statusCode == 401) {
      throw UnauthorizedException(response.statusCode.toString() + " : " + response.body.toString());
    }

    print("ERROR " + response.body.toString());

    throw Exception('Erreur mise à jour utilisateur ' + response.statusCode.toString());

  }

}
