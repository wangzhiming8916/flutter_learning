import 'package:flutter/material.dart';

import '00_base_page.dart';

class AppBarBottomSamplePage extends BasePage {
  AppBarBottomSamplePage({Key key, String title}) : super(key: key, title: title);

  @override
  _AppBarBottomSamplePageState createState() => _AppBarBottomSamplePageState();
}

// ignore: mixin_inherits_from_not_object
class _AppBarBottomSamplePageState extends BasePageState<AppBarBottomSamplePage>
    with SingleTickerProviderStateMixin { // ignore: mixin_inherits_from_not_object
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: choices.length);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _nextPage(int delta) {
    final newIndex = _tabController.index + delta;
    if (newIndex >= 0 && newIndex < _tabController.length) {
      _tabController.animateTo(newIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    final pageSelector = PreferredSize(
      preferredSize: const Size.fromHeight(48.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        height: 48.0,
        alignment: Alignment.center,
        child: Row(
          children: <Widget>[
            IconButton(
              color: Colors.white,
              tooltip: 'Previous choice',
              icon: const Icon(Icons.arrow_back),
              onPressed: () => _nextPage(-1),
            ),
            Expanded(
              child: Center(
                child: TabPageSelector(
                  controller: _tabController,
                  selectedColor: Colors.white,
                ),
              ),
            ),
            IconButton(
              color: Colors.white,
              icon: const Icon(Icons.arrow_forward),
              tooltip: 'Next choice',
              onPressed: () => _nextPage(1),
            )
          ],
        ),
      ),
    );

    final navigationBar = BottomNavigationBar(
      onTap: (index) => setState(() => _nextPage(index - _tabController.index)),
      type: BottomNavigationBarType.shifting,
      fixedColor: Colors.red,
      items: choices.map((choice) {
        return BottomNavigationBarItem(
          backgroundColor: Colors.red,
          icon: Icon(choice.icon),
          title: Text(choice.title),
        );
      }).toList(),
      currentIndex: _tabController.index,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        bottom: pageSelector,
      ),
      body: buildBody(context),
      bottomNavigationBar: navigationBar,
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return TabBarView(
      controller: _tabController,
      children: choices.map((Choice choice) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ChoiceCard(choice: choice),
        );
      }).toList(),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'CAR', icon: Icons.directions_car),
  const Choice(title: 'BICYCLE', icon: Icons.directions_bike),
  const Choice(title: 'BOAT', icon: Icons.directions_boat),
  const Choice(title: 'BUS', icon: Icons.directions_bus),
  const Choice(title: 'TRAIN', icon: Icons.directions_railway),
  const Choice(title: 'WALK', icon: Icons.directions_walk),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.display1;
    return SafeArea(
      child: Card(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(choice.icon, size: 128.0, color: textStyle.color),
              Text(choice.title, style: textStyle),
            ],
          ),
        ),
      ),
    );
  }
}