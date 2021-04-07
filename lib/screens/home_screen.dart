import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_clone/blocs/favorite_bloc.dart';
import 'package:youtube_clone/blocs/videos_bloc.dart';
import 'package:youtube_clone/delegates/data_search.dart';
import 'package:youtube_clone/models/video.dart';
import 'package:youtube_clone/screens/favorites_screen.dart';
import 'package:youtube_clone/widgets/video_tile.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 25.0,
          child: Image.asset("images/yt_logo_rgb_dark.png"),
        ),
        elevation: 0,
        backgroundColor: Colors.black12,
        actions: [
          Align(
            alignment: Alignment.center,
            child: StreamBuilder<Map<String,Video>>(
              stream: BlocProvider.getBloc<FavoriteBloc>().outFav,
              builder: (context, snapshot){
                if(snapshot.hasData)
                  return Text("${snapshot.data.length}");
                else return Container();
              },
            ),
          ),
          IconButton(icon: Icon(Icons.star), onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (c) => FavoriteScreen()));
          }),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                String result =
                    await showSearch(context: context, delegate: DataSearch());
                ;
                if (result != null)
                  BlocProvider.getBloc<VideoBloc>().inSearch.add(result);
              })
        ],
      ),
      backgroundColor: Colors.black,
      body: StreamBuilder(
        stream: BlocProvider.getBloc<VideoBloc>().outVideos,
        initialData: [],
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return ListView.builder(
              itemBuilder: (context, index) {
                if (index < snapshot.data.length)
                  return VideoTile(snapshot.data[index]);
                else if(index > 1){
                  BlocProvider.getBloc<VideoBloc>().inSearch.add(null);
                  return Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.red)));
                }else {
                  return Container();
                }
              },
              itemCount: snapshot.data.length + 1,
            );
          else {
            return Center(
              child: Container(),
            );
          }
        },
      ),
    );
  }
}
