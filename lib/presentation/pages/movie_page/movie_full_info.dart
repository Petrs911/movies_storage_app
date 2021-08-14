import 'package:flutter/material.dart';
import 'package:movies_storage_app/consts/default_image.dart';
import 'package:movies_storage_app/models/movie_model.dart';

class MovieFullInfo extends StatefulWidget {
  const MovieFullInfo({Key? key, required this.movie}) : super(key: key);

  final MovieModel movie;

  @override
  _MovieFullInfoState createState() => _MovieFullInfoState();
}

class _MovieFullInfoState extends State<MovieFullInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.3,
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                widget.movie.backdropPath != null
                    ? 'https://image.tmdb.org/t/p/original${widget.movie.backdropPath}'
                    : imgNotFoundUrl,
                fit: BoxFit.fill,
              ),
            ),
          ),
          ListTile(
            title: Text(widget.movie.title),
            trailing: Text(widget.movie.releseDate?.year.toString() ?? ''),
          ),
        ],
      ),
    );
  }
}
