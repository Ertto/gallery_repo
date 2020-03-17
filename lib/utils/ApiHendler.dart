import 'dart:convert';

import 'package:gallerymobi/utils/Photo.dart';
import 'package:http/http.dart' as http;

class ApiHandler {
  final String _baseUrl;
  final String _apiKey;

  ApiHandler(this._baseUrl, this._apiKey);

  List<Photo> data;

  Future<List<Photo>> loadPhotos(int page) async {
    try {
      var res = await http
          .get("${this._baseUrl}/photos?client_id=${this._apiKey}&page=$page");

      data = (jsonDecode(res.body) as List)
          .map((item) {
            return Photo(
              item["urls"]["regular"].toString(),
              item["urls"]["thumb"].toString(),
            );
          })
          .toList()
          .cast<Photo>();
    } catch (e) {
      throw e;
    }

    return data;
  }
}
