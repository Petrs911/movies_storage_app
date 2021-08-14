import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Настройки')),
      body: ListView(
        children: [
          ValueListenableBuilder(
            valueListenable: Hive.box('themeDate').listenable(),
            builder: (_, Box box, child) {
              bool savedTheme = box.get('isThemeLight', defaultValue: false);
              return ListTile(
                title: Text('Переключить на темную тему'),
                trailing: Switch(
                  value: savedTheme,
                  onChanged: (_) async {
                    savedTheme = !savedTheme;

                    Box box = await Hive.openBox('themeDate');
                    box.put('isThemeLight', savedTheme);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
