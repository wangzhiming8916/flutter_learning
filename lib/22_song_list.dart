import 'package:flutter/material.dart';

import 'app_themes.dart';
import 'view/custom_tab_bar.dart' as custom_tab_bar;
import '00_base_page.dart';

class SongListPage extends BasePage {
  SongListPage({Key key, String title}) : super(key: key, title: title);

  @override
  _SongListPageState createState() => _SongListPageState();
}

class _SongListPageState extends BasePageState<SongListPage> {
  final Map<String, Widget> _pages = <String, Widget>{
    'My Music': Center(child: Text('My Music not implemented')),
    'Shared': Center(child: Text('Shared not implemented')),
    'Feed': FeedTabView(),
  };

  Widget get _leading => Center(
    child: ClipOval(
      child: SizedBox(
        width: 30.0,
        height: 30.0,
        child: Image.network('http://i.imgur.com/TtNPTe0.jpg'),
      ),
    ),
  );

  @override
  List<Widget> get actions => <Widget>[
    IconButton(icon: Icon(Icons.add), onPressed: () {})
  ];

  Widget get _background => Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: FractionalOffset.topCenter,
        end: FractionalOffset.bottomCenter,
        colors: [
          const Color.fromARGB(255, 253, 72, 72),
          const Color.fromARGB(255, 87, 97, 249),
        ],
        stops: [0.0, 1.0],
      ),
    ),
    child: SafeArea(
      bottom: true,
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: Text(
          'T I Z E',
          style: Theme.of(context).textTheme.headline.copyWith(
            color: Colors.grey.shade800.withOpacity(0.8),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );

  Widget get _tabBar => PreferredSize(
    preferredSize: const Size.fromHeight(40.0),
    child: Container(
      height: 40.0,
      margin: const EdgeInsets.all(10.0),
      child: Material(
        color: Colors.grey.shade800.withOpacity(0.5),
        shape: StadiumBorder(),
        child: custom_tab_bar.TabBar(
          indicator: BoxDecoration(
            color: Colors.grey.shade800.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20.0),
          ),
          tabBorderRadius: BorderRadius.circular(20.0),
          tabs: _pages.keys.map((key) => Tab(text: key,)).toList(),
        ),
      ),
    ),
  );

  Widget get _tabController => DefaultTabController(
    length: _pages.length,
    child: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: _leading,
        actions: actions,
        title: const Text('tofu\'s songs'),
        bottom: _tabBar,
      ),
      body: buildBody(context),
    ),
  );

  @override
  Widget buildBody(BuildContext context) {
    return TabBarView(children: _pages.values.toList());
  }

  @override
  build(BuildContext context) {
    return Theme(
      data: darkAppTheme.data,
      child: Stack(children: <Widget>[_background, _tabController]),
    );
  }
}

class FeedTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: MediaQuery.of(context).padding,
      children: [
        SongItem(title: 'Trapadelic lobo', author: 'lillobobeats', likes: 4),
        SongItem(title: 'Different', author: 'younglowkey', likes: 23),
        SongItem(title: 'Future', author: 'younglowkey', likes: 2),
        SongItem(title: 'ASAP', author: 'tha_producer808', likes: 13),
        SongItem(title: '🌲🌲🌲', author: 'TraphousePeyton'),
        SongItem(title: 'Something sweet...', author: '6ryan'),
        SongItem(title: 'Sharpie', author: 'Fergie_6'),
      ],
    );
  }
}

class SongItem extends StatelessWidget {
  const SongItem({ this.title, this.author, this.likes });

  final String title;
  final String author;
  final int likes;

  @override
  Widget build(BuildContext context) {
    final row = Row(
      children: <Widget>[
        ClipOval(
            child: SizedBox(
              width: 40.0,
              height: 40.0,
              child: Image.asset('images/pic2.jpg', fit: BoxFit.cover),
            )
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(title, style: Theme.of(context).textTheme.subhead),
                SizedBox(height: 8.0),
                Text(author, style: Theme.of(context).textTheme.caption),
              ],
            ),
          ),
        ),
        IconButton(
          iconSize: 40.0,
          icon: Icon(Icons.play_arrow),
          onPressed: () {},
        ),
        SizedBox(width: 8.0),
        InkResponse(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.favorite, size: 25.0),
              SizedBox(height: 2.0),
              Text('${likes ?? '0'}'),
            ],
          ),
          onTap: () {},
        ),
        SizedBox(width: 8.0),
      ],
    );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white30,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: row,
    );
  }
}