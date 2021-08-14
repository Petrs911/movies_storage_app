import 'package:flutter/material.dart';
import 'package:movies_storage_app/models/hive_model.dart';

class TempPage extends StatelessWidget {
  TempPage({Key? key, required this.itemsList}) : super(key: key);

  final List<HiveFilmModel> itemsList;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: SizedBox(
          height: 400,
          child: ListView.builder(
              itemCount: itemsList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(itemsList[index].originalTitle),
                  trailing:
                      Text(itemsList[index].releseDate?.year.toString() ?? ''),
                );
              }),
        ),
      ),
    );
  }
}
