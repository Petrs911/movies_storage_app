import 'package:flutter/material.dart';

import 'package:movies_storage_app/consts/default_image.dart';
import 'package:movies_storage_app/models/movie_model.dart';
import 'package:movies_storage_app/presentation/pages/fullscreen_image.dart';

class MovieListTile extends StatelessWidget {
  final MovieModel movie;
  final int index;

  final VoidCallback onTap;

  const MovieListTile({
    Key? key,
    required this.index,
    required this.movie,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => FullscreenImage(movie.posterPath != null
                  ? 'https://image.tmdb.org/t/p/original${movie.posterPath}'
                  : imgNotFoundUrl),
            ),
          );
        },
        child: Hero(
          tag: 'image$index',
          child: SizedBox(
            width: 40,
            child: Image.network(
              movie.posterPath != null
                  ? 'https://image.tmdb.org/t/p/w200${movie.posterPath}'
                  : imgNotFoundUrl,
            ),
          ),
        ),
      ),
      title: Text('${movie.title}'),
      subtitle: Text('${movie.originalTitle}'),
      trailing: Text(movie.releseDate?.year.toString() ?? ''),
    );
  }
}
