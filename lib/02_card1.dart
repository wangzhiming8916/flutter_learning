import 'package:flutter/material.dart';

import '00_base_page.dart';

class CardPage extends BasePage {
  CardPage({Key key, String title}) : super(key: key, title: title);

  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends BasePageState<CardPage> {
  @override
  Widget buildBody(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    final titleText = Container(
      padding: EdgeInsets.all(10.0),
      child: Text(
        'Strawberry Pavlova',
        style: TextStyle(
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
          fontSize: 20.0,
        ),
      ),
    );

    final subTitle = Text(
      'Pavlova is a meringue-based dessert named after the Russian ballerina Anna Pavlova. Pavlova features a crisp crust and soft, light inside, topped with fruit and whipped cream.',
      softWrap: false,
      overflow: TextOverflow.ellipsis,
      maxLines: 3,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'Georgia',
        fontSize: 16.0,
      ),
    );

    final ratings = Container(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.star, color: Colors.green[500], size: 20.0),
              Icon(Icons.star, color: Colors.green[500], size: 20.0),
              Icon(Icons.star, color: Colors.green[500], size: 20.0),
              Icon(Icons.star, color: Colors.black, size: 20.0),
              Icon(Icons.star, color: Colors.black, size: 20.0),
            ],
          ),
          Text(
            '170 Reviews',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w800,
              fontFamily: 'Roboto',
              letterSpacing: 0.5,
              fontSize: 16.0,
            ),
          )
        ],
      ),
    );

    final descTextStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontFamily: 'Roboto',
      letterSpacing: 0.2,
      fontSize: 12.0,
      height: 1.2,
    );

    final iconList = DefaultTextStyle.merge(
      style: descTextStyle,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: Colors.black12),
          borderRadius: const BorderRadius.all(const Radius.circular(5.0)),
        ),
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                Icon(Icons.kitchen, color: Colors.green[500]),
                Text('PREP'),
                Text('25 min'),
              ],
            ),
            Column(
              children: <Widget>[
                Icon(Icons.timer, color: Colors.green[500]),
                Text('COOK'),
                Text('1 hr'),
              ],
            ),
            Column(
              children: <Widget>[
                Icon(Icons.restaurant, color: Colors.green[500]),
                Text('FEEDS'),
                Text('4-6'),
              ],
            ),
          ],
        ),
      ),
    );

    final detailsColumn = Container(
      padding: EdgeInsets.all(20.0),
      width: 300.0,
      height: orientation == Orientation.portrait ? 250.0 : 300.0,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [titleText, subTitle, ratings, iconList],
      ),
    );

    final mainImage = Container(
      width: 300.0,
      height: orientation == Orientation.portrait ? 200.0 : 300.0,
      child: Image.asset('images/pavlova.jpg', fit: BoxFit.cover),
    );

    final content = orientation == Orientation.portrait
        ? Column(children: [mainImage, detailsColumn])
        : Row(children: [detailsColumn, mainImage]);

    return SafeArea(
      top: false,
      bottom: true,
      child: Center(
        child: Container(
          margin: EdgeInsets.all(20.0),
          width: orientation == Orientation.portrait ? 308.0 : 608.0,
          height: orientation == Orientation.portrait ? 458.0 : 308.0,
          child: Card(elevation: 4.0, child: content),
        ),
      ),
    );
  }
}