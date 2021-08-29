import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movies_storage_app/consts/default_image.dart';
import 'package:movies_storage_app/models/movie_model.dart';
import 'package:movies_storage_app/presentation/blocs/actorss_bloc/bloc.dart';
import 'package:movies_storage_app/styles/text_style.dart';

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
        Tween<double>(begin: 175, end: 30).animate(_colorAnimationController);
  }

  bool _scrollListener(ScrollNotification scrollNotification) {
    if (scrollNotification.metrics.axis == Axis.vertical) {
      _colorAnimationController
          .animateTo(scrollNotification.metrics.pixels / 150);

      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: NotificationListener(
          onNotification: _scrollListener,
          child: SizedBox(
            height: double.infinity,
            child: Stack(
              children: <Widget>[
                ScrollConfiguration(
                  behavior: _MyCustomScrollBehavior(),
                  child: ListView(
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Image.network(widget.movie.backdropPath != null
                            ? 'https://image.tmdb.org/t/p/original${widget.movie.backdropPath}'
                            : imgNotFoundUrl),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 55),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(widget.movie.title, style: title),
                            const SizedBox(height: 20),
                            Text(widget.movie.overview, style: description),
                            const SizedBox(height: 20),
                            Text('Оригинальное название',
                                style: mediumGreyTitle),
                            const SizedBox(height: 10),
                            Text(
                              widget.movie.originalTitle,
                              style: description,
                            ),
                            BlocBuilder<ActorsBloc, ActorsState>(
                              builder: (_, ActorsState state) {
                                if (state is LoadedState) {
                                  return SizedBox(
                                      // child: ListView.builder(
                                      //   physics:
                                      //       const NeverScrollableScrollPhysics(),
                                      //   shrinkWrap: true,
                                      //   itemCount: state.actorsList.length,
                                      //   itemBuilder: (_, int index) => Text(
                                      //     state.actorsList[index].name,
                                      //     style: description,
                                      //   ),
                                      // ),
                                      );
                                }
                                if (state is ErrorState) {
                                  return SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    child: Text(
                                      'Упс, что-то пошло не так\n${state.error}',
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                }

                                return CircularProgressIndicator();
                              },
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.width,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedBuilder(
                  animation: _colorAnimationController,
                  builder: (_, Widget? child) => Positioned(
                    left: _offsetDx.value,
                    top: _offsetDy.value,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.52,
                      height: 50,
                      child: Center(
                        child: Text(
                          widget.movie.voteAverage.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            blurRadius: 20,
                            spreadRadius: 3,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.09,
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
              onPressed: () {
                print(widget.movie.movieId);
              },
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
