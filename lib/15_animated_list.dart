import 'package:flutter/material.dart';

import '00_base_page.dart';

class AnimatedListPage extends BasePage {
  AnimatedListPage({Key key, String title}) : super(key: key, title: title);
  
  @override
  _AnimatedListPageState createState() => _AnimatedListPageState();
}

class _AnimatedListPageState extends BasePageState<AnimatedListPage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<int> _list = <int>[0, 1, 2];
  int _selectedItem;
  int _nextItem;

  @override
  void initState() {
    super.initState();
    _nextItem = _list.length;
  }

  void _insert() {
    final int index = _selectedItem == null ? _list.length : _list.indexOf(_selectedItem);
    _list.insert(index, _nextItem++);
    _listKey.currentState.insertItem(index);
  }

  void _remove() {
    if (_selectedItem == null) {
      return;
    }

    final index = _list.indexOf(_selectedItem);
    final removedItem = _list.removeAt(index);
    if (removedItem != null) {
      _listKey.currentState.removeItem(index, (BuildContext context, Animation<double> animation) {
        return CardItem(
          animation: animation,
          item: index,
          selected: true,
        );
      });
    }

    setState(() => _selectedItem = null);
  }

  @override
  List<Widget> get actions => <Widget>[
    IconButton(
      icon: const Icon(Icons.add_circle),
      onPressed: _insert,
      tooltip: 'insert a item',
    ),
    IconButton(
      icon: const Icon(Icons.remove_circle),
      onPressed: _remove,
      tooltip: 'remove the selected item',
    ),
  ];

  @override
  Widget buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedList(
        key: _listKey,
        initialItemCount: _list.length,
        itemBuilder: (context, index, animation) => CardItem(
          animation: animation,
          item: _list[index],
          selected: _selectedItem == _list[index],
          onTap: () {
            setState(() {
              _selectedItem = _selectedItem == _list[index] ? null : _list[index];
            });
          },
        ),
      ),
    );
  }
}

class CardItem extends StatelessWidget {
   CardItem({
    Key key,
    @required this.animation,
    this.onTap,
    @required this.item,
    this.selected: false
  })  : assert(animation != null),
        assert(item != null && item >= 0),
        assert(selected != null),
        super(key: key);

  final Animation<double> animation;
  final VoidCallback onTap;
  final int item;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.display1;
    if (selected) {
      textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: SizeTransition(
        axis: Axis.vertical,
        sizeFactor: animation,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: SizedBox(
            height: 128.0,
            child: Card(
              color: selected
                  ? Colors.accents[item % Colors.accents.length]
                  : Colors.primaries[item % Colors.primaries.length],
              child: Center(
                child: Text('Item $item', style: textStyle),
              ),
            ),
          ),
        ),
      ),
    );
  }
}