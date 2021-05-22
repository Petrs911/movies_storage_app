import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movies_storage_app/bloc/movie_bloc.dart';
import 'package:movies_storage_app/pages/home_page.dart';
import 'package:movies_storage_app/pages/movie_selection.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Search'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final movieName = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieSelection(),
                ),
              );
              if (movieName != null) {
                BlocProvider.of<MovieBloc>(context)
                    .add(GetMoviesEvent(movieName: movieName));
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
                child: Text('Please select a movie'),
              );
            }
            if (state is MovieLoadingState) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is MovieLoadedState) {
              final movieList = state.movieList;

              return ListView.builder(
                itemCount: movieList.length,
                itemBuilder: (context, index) =>
                    MyHomePage(movie: movieList[index]),
              );
            }
            if (state is MovieErrorState) {
              return Text('Упс, что-то пошло не так\n${state.error}');
            }
          },
        ),
      ),
    );
  }
}
