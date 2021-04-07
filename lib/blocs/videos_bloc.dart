import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:youtube_clone/api.dart';
import 'package:youtube_clone/models/video.dart';
class VideoBloc implements BlocBase {


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
    if(search != null){
      _videoController.sink.add([]);
      videos = await api.search(search);
    }else {
      videos += await api.nextPage();
    }
    _videoController.sink.add(videos);

  }
  @override
  void dispose() {
    _videoController.close();
    _searchController.close();
  }

  @override
  void addListener(listener) {
    // TODO: implement addListener
  }

  @override
  // TODO: implement hasListeners
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
  }

  @override
  void removeListener(listener) {
    // TODO: implement removeListener
  }

}