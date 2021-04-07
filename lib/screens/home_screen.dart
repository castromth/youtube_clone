import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_clone/blocs/videos_bloc.dart';
import 'package:youtube_clone/delegates/data_search.dart';
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
        backgroundColor: Colors.black87,
        actions: [
          Align(
            alignment: Alignment.center,
            child: Text("0"),
          ),
          IconButton(icon: Icon(Icons.star), onPressed: () {}),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                String result = await showSearch(context: context, delegate: DataSearch());;
                if(result != null) BlocProvider.getBloc<VideoBloc>().inSearch.add(result);
              })
        ],
      ),
      backgroundColor: Colors.black ,
      body: StreamBuilder(
        stream: BlocProvider.getBloc<VideoBloc>().outVideos,
        builder: (context , snapshot){
          if(snapshot.hasData)
            return ListView.builder(
                itemBuilder: (context,index){
                  return VideoTile(snapshot.data[index]);
                },
              itemCount: snapshot.data.length,
            );
          else{
            return Center(
              child: Container(),
            );
          }
        },
      ),
    );
  }
}
