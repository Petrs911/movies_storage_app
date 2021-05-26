import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movies_storage_app/blocs/movie_bloc.dart';
import 'package:movies_storage_app/pages/home_page.dart';
import 'package:movies_storage_app/pages/movie_selection.dart';
import 'package:movies_storage_app/pages/settings.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool toogler = true;

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
            icon: Icon(Icons.search),
            onPressed: () async {
              setState(() => toogler = true);
              final movieName = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieSelection(),
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
            if (state is MovieLoadingState) {
              return Center(child: CircularProgressIndicator());
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
                            movieList.sort(
                                (a, b) => b.releseDate.compareTo(a.releseDate));
                            setState(() {});
                            toogler = false;
                          } else {
                            movieList.sort(
                                (a, b) => a.releseDate.compareTo(b.releseDate));
                            setState(() {});
                            toogler = true;
                          }
                        },
                        child:
                            Text(toogler ? 'Сначала новые' : 'Сначала старые'),
                      ),
                    ],
                  ),
                  //SizedBox(height: 10.0),
                  Expanded(
                    child: ListView.builder(
                      itemCount: movieList.length,
                      itemBuilder: (context, index) =>
                          MyHomePage(movie: movieList[index], index: index),
                    ),
                  ),
                ],
              );
            }
            if (state is MovieErrorState) {
              return Center(
                  child: Text('Упс, что-то пошло не так\n${state.error}'));
            }
          },
        ),
      ),
    );
  }
}
