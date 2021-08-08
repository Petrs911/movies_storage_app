import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_storage_app/models/hive_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import 'package:movies_storage_app/presentation/blocs/movie_bloc.dart';
import 'package:movies_storage_app/presentation/blocs/theme_bloc.dart';
import 'package:movies_storage_app/presentation/pages/home_page.dart';
import 'package:movies_storage_app/provider/provider.dart';
import 'package:movies_storage_app/repository/movies_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Directory directory = await getApplicationDocumentsDirectory();

  Hive.init(directory.path);
  Hive.registerAdapter(HiveModelAdapter());

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
  MyApp({Key? key, required this.moviesRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeData>(
      builder: (context, state) {
        return MaterialApp(
          theme: state,
          title: 'Movie app',
          home: BlocProvider(
            create: (context) {
              BlocProvider.of<ThemeBloc>(context).add(GetSavedTheme());
              return MovieBloc(moviesRepository: moviesRepository);
            },
            child: HomePage(),
          ),
        );
      },
    );
  }
}
