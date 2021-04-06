import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models/video.dart';

const API_KEY = "AIzaSyDiPu4AG3KYmu0aFbEjPa6vQJlpmuuuN4Q";


class Api {


  search(String search) async {
    http.Response response = await http.get(
      Uri.parse("https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10")
    );

    decode(response);
  }

  decode(http.Response response) {

    if(response.statusCode == 200){
      var decoded = json.decode(response.body);
      List<Video> videos = decoded["items"].map<Video>( (map) {
        return Video.fromJson(map);
      }).toList();
      print(decoded);
    } else {
      throw Exception("Falied to load videos");
    }
  }
}