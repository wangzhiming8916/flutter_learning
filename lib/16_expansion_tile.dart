import 'package:flutter/material.dart';

import '00_base_page.dart';

class ExpansionTilePage extends BasePage {
  ExpansionTilePage({Key key, String title}) : super(key: key, title: title);
  
  @override
  _ExpansionTilePageState createState() => _ExpansionTilePageState();
}

class _ExpansionTilePageState extends BasePageState<ExpansionTilePage> {
  final data = <Entry>[
    Entry(
      'Chapter A',
      children: <Entry>[
        Entry(
          'Section A0',
          children: <Entry>[
            Entry('Item A0.1'),
            Entry('Item A0.2'),
            Entry('Item A0.3'),
          ],
        ),
        Entry('Section A1'),
        Entry('Section A2'),
      ],
    ),
    Entry(
      'Chapter B',
      children: <Entry>[
        Entry('Section B0'),
        Entry('Section B1'),
      ],
    ),
    Entry(
      'Chapter C',
      children: <Entry>[
        Entry('Section C0'),
        Entry('Section C1'),
        Entry(
          'Section C2',
          children: <Entry>[
            Entry('Item C2.0'),
            Entry('Item C2.1'),
            Entry('Item C2.2'),
            Entry('Item C2.3'),
          ],
        ),
      ],
    ),
  ];

  @override
  Widget buildBody(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => EntryItem(entry: data[index]),
      itemCount: data.length,
    );
  }
}

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class EntryItem extends StatelessWidget {
  const EntryItem({this.entry});

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty)
      return ListTile(title: Text(root.title));
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}

class Entry {
  Entry(this.title, {this.children = const <Entry>[]});

  final String title;
  final List<Entry> children;
}