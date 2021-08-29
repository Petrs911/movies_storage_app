import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_storage_app/models/hive_model.dart';
import 'package:movies_storage_app/presentation/blocs/movie_bloc/bloc.dart';
import 'package:movies_storage_app/provider/dio_client.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:movies_storage_app/presentation/pages/home_page.dart';
import 'package:movies_storage_app/repository/movies_repository.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );

  WidgetsFlutterBinding.ensureInitialized();
  final Directory directory = await getApplicationDocumentsDirectory();

  Hive.init(directory.path);
  Hive.registerAdapter(HiveFilmModelAdapter());
  await Hive.openBox<HiveFilmModel>('moviesList');

  final MoviesRepository moviesRepository = MoviesRepository(DioClient());

  runApp(
    MyApp(moviesRepository: moviesRepository),
  );
}

class MyApp extends StatelessWidget {
  final MoviesRepository moviesRepository;
  MyApp({Key? key, required this.moviesRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Questrial',
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
            shape: MaterialStateProperty.all<StadiumBorder>(
              StadiumBorder(),
            ),
          ),
        ),
        primaryColor: Colors.black,
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Movie app',
      home: BlocProvider(
        create: (context) {
          return MovieBloc(moviesRepository: moviesRepository);
        },
        child: HomePage(moviesRepository: moviesRepository),
      ),
    );
  }
}
