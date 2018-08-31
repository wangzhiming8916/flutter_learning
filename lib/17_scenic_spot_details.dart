import 'package:flutter/material.dart';

import '00_base_page.dart';

class ScenicSpotDetailsPage extends BasePage {
  ScenicSpotDetailsPage({Key key, String title}) : super(key: key, title: title);

  @override
  _ScenicSpotDetailsPageState createState() => _ScenicSpotDetailsPageState();
}

class _ScenicSpotDetailsPageState extends BasePageState<ScenicSpotDetailsPage> {
  @override
  Widget buildBody(BuildContext context) {
    final titleSection = Container(
      padding: const EdgeInsets.all(32.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Oeschinen Lake Campground",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  "Kandersteg, Switzerland",
                  style: TextStyle(color: Colors.grey[500]),
                ),
              ],
            ),
          ),
          FavoriteWidget(),
        ],
      ),
    );

    Widget buildButtonColumn(IconData icon, String label) {
      Color color = Theme.of(context).primaryColor;
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, color: color),
          Container(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          ),
        ],
      );
    }

    final buttonSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        buildButtonColumn(Icons.call, "CALL"),
        buildButtonColumn(Icons.near_me, "ROUTE"),
        buildButtonColumn(Icons.share, "SHARE"),
      ],
    );

    final textSection = Container(
      padding: const EdgeInsets.all(32.0),
      child: Text(
        "Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.",
        softWrap: true,
      ),
    );

    return ListView(
      children: <Widget>[
        Image.asset("images/lake.jpg", height: 240.0, fit: BoxFit.cover),
        titleSection,
        buttonSection,
        textSection,
      ],
    );
  }
}

class FavoriteWidget extends StatefulWidget {
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = true;
  int _favoriteCount = 41;

  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
      _favoriteCount += _isFavorited ? 1 : -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          onPressed: _toggleFavorite,
          icon: Icon(
            _isFavorited ? Icons.star : Icons.star_border,
            color: Colors.red[500],
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(minWidth: 20.0),
          child: Text('$_favoriteCount'),
        ),
      ],
    );
  }
}