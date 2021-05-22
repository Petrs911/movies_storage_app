import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:movies_storage_app/blocs/movie_bloc.dart';
import 'package:movies_storage_app/blocs/theme_bloc.dart';
import 'package:movies_storage_app/provider/provider.dart';
import 'package:movies_storage_app/pages/search_page.dart';
import 'package:movies_storage_app/repository/movies_repository.dart';

void main() {
  final MoviesRepository moviesRepository = MoviesRepository(
      moviesProvider: MoviesProvider(httpClient: http.Client()));

  runApp(
    BlocProvider(
      create: (context) => ThemeBloc(),
      child: MyApp(moviesRepository: moviesRepository),
    ),
  );
}

class MyApp extends StatelessWidget {
  final MoviesRepository moviesRepository;
  MyApp({Key key, @required this.moviesRepository})
      : assert(moviesRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeData>(
      builder: (context, state) {
        return MaterialApp(
          theme: state,
          title: 'Movie app',
          home: BlocProvider(
            create: (context) => MovieBloc(moviesRepository: moviesRepository),
            child: SearchPage(),
          ),
        );
      },
    );
  }
}
