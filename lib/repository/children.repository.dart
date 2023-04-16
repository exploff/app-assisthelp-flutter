import 'dart:io';

import 'package:app_assisthelp/model/children.model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../exception/unauthorized.exception.dart';

class ChildrenRepository {
  static String mainUrl = "10.0.2.2:8080";
  var currentChildrensUrl = '/children/current-childrens';

  final FlutterSecureStorage storage = FlutterSecureStorage();


  Future<List<Children>> getCurrentChildrens() async {
    
    var url = Uri.http(mainUrl, currentChildrensUrl);

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
    
    List<Children> childrens = [];

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
      for (var item in jsonResponse['data']) {
        childrens.add(Children.fromJson(item));
      }
      return childrens;
    }

    print("ERROR " + response.statusCode.toString());
    if (response.statusCode == 401) {
      throw UnauthorizedException(response.statusCode.toString() + " : " + response.body.toString());
    }

    throw Exception('Erreur récupération des enfants ' + response.statusCode.toString());
  }
}
