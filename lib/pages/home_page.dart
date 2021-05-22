import 'package:flutter/material.dart';

import 'package:movies_storage_app/model/movie_model.dart';
import 'package:movies_storage_app/pages/fullscreen_image.dart';
import 'package:movies_storage_app/default_image.dart';

class MyHomePage extends StatelessWidget {
  final MoviesModel movie;

  MyHomePage({Key key, @required this.movie})
      : assert(movie != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: movie.image == null
          ? Image.network(img)
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
                tag: 'imageHero',
                child: Image.network(
                    'https://image.tmdb.org/t/p/w200${movie.image}'),
              ),
            ),
      title: Text('${movie.title}'),
      subtitle: Text('${movie.originalTitle}'),
      trailing: Text('${movie.releseDate}'),
    );
  }
}
