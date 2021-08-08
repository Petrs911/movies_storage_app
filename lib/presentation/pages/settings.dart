import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movies_storage_app/presentation/blocs/theme_bloc.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Настройки')),
      body: ListView(
        children: [
          BlocBuilder<ThemeBloc, ThemeData>(
            builder: (context, state) {
              return ListTile(
                title: Text('Переключить на темную тему'),
                trailing: Switch(
                  value: state != ThemeData.light(),
                  onChanged: (_) =>
                      BlocProvider.of<ThemeBloc>(context).add(ThemeChanged()),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
