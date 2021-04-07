import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:youtube_clone/api.dart';
import 'package:youtube_clone/blocs/favorite_bloc.dart';
import 'package:youtube_clone/models/video.dart';


class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Favoritos"),
          centerTitle: true,
          backgroundColor: Colors.black12),
      body: StreamBuilder<Map<String, Video>>(
        stream: BlocProvider.getBloc<FavoriteBloc>().outFav,
        initialData: {},
        builder: (context, snapshot) {
          return ListView(
            children: snapshot.data.values.map((e) {
              return InkWell(
                onTap: () {
                  FlutterYoutube.playYoutubeVideoById(apiKey: API_KEY, videoId: e.id);
                },
                onLongPress: () {
                  BlocProvider.getBloc<FavoriteBloc>().toggleFavorite(e);
                },
                child: Row(
                  children: [
                    Container(
                      width: 100,
                      height: 50,
                      child: Image.network(e.thumb),
                    ),
                    Expanded(
                      child: Text(
                        e.title,
                        style: TextStyle(color: Colors.white70),
                        maxLines: 2,
                      ),
                    )
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    backgroundColor: Colors.black54,);
  }
}
