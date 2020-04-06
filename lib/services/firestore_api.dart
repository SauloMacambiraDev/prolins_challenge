import 'dart:convert';

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class FirestoreApi {
  final String collectionName;
  String URL;
  Map _header = {'token': ''};

  FirestoreApi(this.collectionName) {
    this.URL = 'someUrl/$collectionName';
  }

  void getToken() async {
//    final urlToken = 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithCustomToken?key='
    final http.Response response = await http.get('getTokenUrl');
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      this._header['token'] = body.token;
    }
  }

  Future<http.Response> addDocument(data) async {
    return await http.post(this.URL, headers: this._header, body: data);
  }
}
