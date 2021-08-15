import 'package:flutter/material.dart';
import 'package:movies_storage_app/consts/default_image.dart';
import 'package:movies_storage_app/models/movie_model.dart';

class MovieFullInfo extends StatefulWidget {
  const MovieFullInfo({Key? key, required this.movie}) : super(key: key);

  final MovieModel movie;

  @override
  _MovieFullInfoState createState() => _MovieFullInfoState();
}

class _MovieFullInfoState extends State<MovieFullInfo>
    with TickerProviderStateMixin {
  late final AnimationController _colorAnimationController;
  late final Animation _colorTween;
  late final Animation _offsetDx;
  late final Animation _offsetDy;

  @override
  void initState() {
    super.initState();
    _colorAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));
    _colorTween = ColorTween(begin: Colors.transparent, end: Colors.black)
        .animate(_colorAnimationController);
    _offsetDx =
        Tween<double>(begin: 85, end: -200).animate(_colorAnimationController);
    _offsetDy =
        Tween<double>(begin: 185, end: 50).animate(_colorAnimationController);
  }

  bool _scrollListener(ScrollNotification scrollNotification) {
    if (scrollNotification.metrics.axis == Axis.vertical) {
      _colorAnimationController
          .animateTo(scrollNotification.metrics.pixels / 140);

      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NotificationListener(
          onNotification: _scrollListener,
          child: SizedBox(
            height: double.infinity,
            child: Stack(
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Image.network(widget.movie.backdropPath != null
                          ? 'https://image.tmdb.org/t/p/original${widget.movie.backdropPath}'
                          : imgNotFoundUrl),
                    ),
                    Container(
                      height: 300,
                      color: Colors.red,
                    ),
                    Container(
                      height: 300,
                      color: Colors.green,
                    ),
                    Container(
                      height: 300,
                      color: Colors.red,
                    ),
                    Container(
                      height: 300,
                      color: Colors.green,
                    ),
                  ],
                ),
                AnimatedBuilder(
                  animation: _colorAnimationController,
                  builder: (_, Widget? child) => Positioned(
                    left: _offsetDx.value,
                    top: _offsetDy.value,
                    child: Container(
                      width: 200,
                      height: 40,
                      color: Colors.blue,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: AnimatedBuilder(
                    animation: _colorAnimationController,
                    builder: (_, Widget? child) => AppBar(
                      elevation: 0,
                      title: Text(widget.movie.title),
                      backgroundColor: _colorTween.value,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Добавить в библиотеку'),
            ),
          ),
        ),
      ),
    );
  }
}

class _MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
          BuildContext context, Widget child, ScrollableDetails details) =>
      child;
}
