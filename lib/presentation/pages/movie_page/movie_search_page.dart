import 'package:flutter/material.dart';

class MovieSearch extends StatefulWidget {
  @override
  _MovieSearchState createState() => _MovieSearchState();
}

class _MovieSearchState extends State<MovieSearch> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocuse = FocusScope.of(context);
        if (!currentFocuse.hasPrimaryFocus) {
          currentFocuse.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Поиск фильма'),
        ),
        body: Form(
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: TextFormField(
                    autofocus: true,
                    onFieldSubmitted: (String? str) {
                      if (str != null) {
                        if (str.isEmpty) return;
                        Navigator.pop(context, str);
                      }
                    },
                    controller: _textController,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.white),
                      labelText: 'Поиск',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  if (_textController.text.isEmpty) return;
                  Navigator.pop(context, _textController.text);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
