import 'package:flutter/material.dart';

class FullscreenImage extends StatelessWidget {
  final String img;

  const FullscreenImage(this.img);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(this.img),
          ),
        ),
        onTap: () => Navigator.pop(context),
      ),
    );
  }
}
