import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_clone/blocs/videos_bloc.dart';
import 'package:youtube_clone/screens/home_screen.dart';

import 'api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [Bloc((i) => VideoBloc())],
      child: MaterialApp(
        title: 'YoutubeClone',
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}


