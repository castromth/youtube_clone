import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:youtube_clone/api.dart';
import 'package:youtube_clone/models/video.dart';
class VideoBloc  {


  Api api;
  List<Video> videos;
  final StreamController<List<Video>> _videoController = StreamController<List<Video>>();
  Stream get outVideos => _videoController.stream;
  
  final StreamController<String> _searchController = StreamController<String>();
  Sink get inSearch => _searchController.sink;
  VideoBloc(){
    api = Api();
    _searchController.stream.listen(_search);
  }


  void _search(String search) async {
    videos = await api.search(search);

  }

  void dispose() {
    _videoController.close();
    _searchController.close();
  }

}