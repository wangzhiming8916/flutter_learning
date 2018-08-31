import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

import 'view/view.dart' show ListTileCell;
import '00_base_page.dart';

class RandomWordsPage extends BasePage {
  RandomWordsPage({Key key, String title}) : super(key: key, title: title);

  @override
  createState() => _RandomWordsPageState();
}

class _RandomWordsPageState extends BasePageState<RandomWordsPage> {
  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  List<Widget> get actions => <Widget>[
    IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
  ];

  @override
  Widget buildBody(BuildContext context) {
    return ListView.builder(
      padding: MediaQuery.of(context).padding.copyWith(left: 16.0, top: 0.0, right: 16.0),
      itemCount: 20,
      itemBuilder: (context, index) {
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(20));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTileCell(
      title: Text(pair.asPascalCase, style: _biggerFont),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () => setState(() => alreadySaved ? _saved.remove(pair) : _saved.add(pair)),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      final tiles = _saved.map((pair) => ListTile(
        title: Text(pair.asPascalCase, style: _biggerFont),
      ));
      final divided = ListTile.divideTiles(context: context, tiles: tiles).toList();

      return Scaffold(
        appBar: AppBar(title: Text("Saved Suggestions")),
        body: ListView(children: divided),
      );
    }));
  }
}