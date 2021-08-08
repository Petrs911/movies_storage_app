import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:movies_storage_app/models/hive_model.dart';
import 'package:movies_storage_app/models/movie_model.dart';

import 'package:movies_storage_app/presentation/blocs/movie_bloc.dart';
import 'package:movies_storage_app/presentation/pages/movie_listtile.dart';
import 'package:movies_storage_app/presentation/pages/movie_search_page.dart';
import 'package:movies_storage_app/presentation/pages/settings.dart';
import 'package:movies_storage_app/presentation/pages/temp_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool toogler = true;

  List<HiveModel> _itemsList = <HiveModel>[];

  Future<void> addItem(HiveModel item) async {
    var box = await Hive.openBox<HiveModel>('item');

    box.add(item);
  }

  Future<void> getItem() async {
    Box box = await Hive.openBox<HiveModel>('item');
    _itemsList = box.values.toList() as List<HiveModel>;
  }

  int stringToint(MovieModel movieModel) {
    int movieRealeseDate =
        int.parse(movieModel.releseDate?.year.toString() ?? '0');
    return movieRealeseDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Поиск фильмов'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Settings(),
              ),
            ),
          ),
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {
                await getItem();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TempPage(
                      itemsList: _itemsList,
                    ),
                  ),
                );
              }),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              setState(() => toogler = true);
              final movieName = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieSearch(),
                ),
              );
              if (movieName != null) {
                BlocProvider.of<MovieBloc>(context).add(
                  GetMoviesEvent(movieName: movieName),
                );
              }
            },
          )
        ],
      ),
      body: Center(
        child: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            if (state is MovieInitial) {
              return Center(
                child: Text('Пожалуйста введите название фильма'),
              );
            }
            if (state is MovieLoadedEmptyListState) {
              return Center(
                child: Text(
                    'Извините не удалось найти данный фильм: "${state.movieName}"'),
              );
            }
            if (state is MovieLoadedState) {
              final movieList = state.movieList;

              return Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Найденно фильмов: ${movieList.length}'),
                      OutlinedButton(
                        onPressed: () {
                          if (toogler) {
                            movieList.sort((a, b) =>
                                stringToint(b).compareTo(stringToint(a)));
                            setState(() {});
                            toogler = false;
                          } else {
                            movieList.sort((a, b) =>
                                stringToint(a).compareTo(stringToint(b)));
                            setState(() {});
                            toogler = true;
                          }
                        },
                        child:
                            Text(toogler ? 'Сначала новые' : 'Сначала старые'),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: movieList.length,
                      itemBuilder: (context, index) => MovieListTile(
                        onTap: () async {
                          final SnackBar snackBar = SnackBar(
                            backgroundColor: Colors.red,
                            content: const Text(
                                'Данный фильм уже добавлен в вашу библиотеку'),
                            action: SnackBarAction(
                              label: 'OK',
                              onPressed: () {},
                            ),
                          );

                          await getItem();
                          if (_itemsList.isEmpty) {
                            addItem(HiveModel(
                              posterPath: movieList[index].posterPath,
                              title: movieList[index].title,
                              originalTitle: movieList[index].originalTitle,
                              realeseDate: movieList[index].releseDate,
                            ));
                          }
                          _itemsList.forEach((HiveModel hiveModel) async {
                            if (hiveModel.originalTitle ==
                                    movieList[index].originalTitle &&
                                hiveModel.realeseDate ==
                                    movieList[index].releseDate) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              await addItem(HiveModel(
                                posterPath: movieList[index].posterPath,
                                title: movieList[index].title,
                                originalTitle: movieList[index].originalTitle,
                                realeseDate: movieList[index].releseDate,
                              ));
                            }
                          });
                        },
                        movie: movieList[index],
                        index: index,
                      ),
                    ),
                  ),
                ],
              );
            }
            if (state is MovieErrorState) {
              return SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  'Упс, что-то пошло не так\n${state.error}',
                  textAlign: TextAlign.center,
                ),
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
