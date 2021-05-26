import 'package:flutter/material.dart';

import 'package:movies_storage_app/model/movie_model.dart';
import 'package:movies_storage_app/pages/fullscreen_image.dart';
import 'package:movies_storage_app/consts/default_image.dart';

class MovieListTile extends StatelessWidget {
  final MoviesModel movie;
  final int index;

  const MovieListTile({Key key, @required this.index, @required this.movie})
      : assert(movie != null, index != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: movie.image == null
          ? defaultImg
          : GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FullscreenImage(
                        'https://image.tmdb.org/t/p/original${movie.image}'),
                  ),
                );
              },
              child: Hero(
                tag: 'image$index',
                child: Image.network(
                    'https://image.tmdb.org/t/p/w200${movie.image}'),
              ),
            ),
      title: Text('${movie.title}'),
      subtitle: Text('${movie.originalTitle}'),
      trailing: Text(movie.releseDate == 1 ? '' : '${movie.releseDate}'),
    );
  }
}
