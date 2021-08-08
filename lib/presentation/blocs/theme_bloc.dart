import 'dart:async';

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeData> {
  ThemeBloc() : super(ThemeData.light());

  @override
  Stream<ThemeData> mapEventToState(ThemeEvent event) async* {
    if (event is GetSavedTheme) {
      yield await getValue();
    }
    if (event is ThemeChanged) {
      yield state == ThemeData.light() ? ThemeData.dark() : ThemeData.light();
      await saveValue(state == ThemeData.light());
    }
  }

  Future<ThemeData> getValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLight = prefs.getBool('isLight') ?? true;
    return isLight ? ThemeData.light() : ThemeData.dark();
  }

  Future<void> saveValue(bool isLight) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLight', isLight);
  }
}
