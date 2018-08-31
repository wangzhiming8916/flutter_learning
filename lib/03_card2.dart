import 'package:flutter/material.dart';

import '00_base_page.dart';

class TravelDestinationPage extends BasePage {
  TravelDestinationPage({Key key, String title}) : super(key: key, title: title);

  @override
  _TravelDestinationPageState createState() => _TravelDestinationPageState();
}

const String _galleryAssetsPackage = 'flutter_gallery_assets';

class _TravelDestinationPageState extends BasePageState<TravelDestinationPage> {
  ShapeBorder _shape;

  final List<TravelDestination> _destinations = const <TravelDestination>[
    const TravelDestination(
      assetName: 'places/india_thanjavur_market.png',
      assetPackage: _galleryAssetsPackage,
      title: 'Top 10 Cities to Visit in Tamil Nadu',
      description: <String>[
        'Number 10',
        'Thanjavur',
        'Thanjavur, Tamil Nadu',
      ],
    ),
    const TravelDestination(
      assetName: 'places/india_chettinad_silk_maker.png',
      assetPackage: _galleryAssetsPackage,
      title: 'Artisans of Southern India',
      description: <String>[
        'Silk Spinners',
        'Chettinad',
        'Sivaganga, Tamil Nadu',
      ],
    )
  ];


  @override
  List<Widget> get actions => <Widget>[
    IconButton(
      icon: const Icon(Icons.sentiment_very_satisfied),
      onPressed: () {
        setState(() {
          _shape = _shape != null ? null : const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
              bottomLeft: Radius.circular(2.0),
              bottomRight: Radius.circular(2.0),
            ),
          );
        });
      },
    ),
  ];

  @override
  Widget buildBody(BuildContext context) {
    return SafeArea(
      top: false,
      child: ListView(
        itemExtent: TravelDestinationItem.height,
        padding: const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
        children: _destinations.map((destination) {
          return Container(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: TravelDestinationItem(destination: destination, shape: _shape),
          );
        }).toList(),
      ),
    );
  }
}

class TravelDestinationItem extends StatelessWidget {
  static const double height = 366.0;
  final TravelDestination destination;
  final ShapeBorder shape;

  TravelDestinationItem({Key key, @required this.destination, this.shape})
      : assert(destination != null && destination.isValid),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final titleStyle = themeData.textTheme.headline.copyWith(color: Colors.white);
    final descriptionStyle = themeData.textTheme.subhead;

    final header = SizedBox(
      height: 184.0,
      child: Container(
        color: Colors.blue,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned.fill(
              child: Image.asset(
                destination.assetName,
                package: destination.assetPackage,
                fit: BoxFit.cover,
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.0, 1.0),
                  end: Alignment(0.0, 0.2),
                  colors: <Color>[Color(0x60000000), Color(0x00000000)],
                ),
              ),
            ),
            Positioned(
              left: 16.0,
              right: 16.0,
              bottom: 16.0,
              child: FittedBox(
                alignment: Alignment.centerLeft,
                fit: BoxFit.scaleDown,
                child: Text(destination.title, style: titleStyle),
              ),
            ),
          ],
        ),
      ),
    );

    final body = Expanded(
      child: Container(
        margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
        child: DefaultTextStyle(
          softWrap: false,
          overflow: TextOverflow.ellipsis,
          style: descriptionStyle,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  destination.description[0],
                  style: descriptionStyle.copyWith(color: Colors.black54),
                ),
              ),
              Text(destination.description[1]),
              Text(destination.description[2]),
            ],
          ),
        ),
      ),
    );

    final footer = ButtonTheme.bar(
      child: ButtonBar(
        alignment: MainAxisAlignment.start,
        children: <Widget>[
          FlatButton(
            child: const Text('SHARE'),
            textColor: Colors.amber.shade500,
            onPressed: () { /* do nothing */ },
          ),
          FlatButton(
            child: const Text('EXPLORE'),
            textColor: Colors.amber.shade500,
            onPressed: () { /* do nothing */ },
          ),
        ],
      ),
    );

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: shape,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[header, body, footer],
        ),
      ),
    );
  }
}

class TravelDestination {
  const TravelDestination({
    @required this.assetName,
    @required this.assetPackage,
    @required this.title,
    @required this.description
  })  : assert(assetName != null),
        assert(assetPackage != null),
        assert(title != null),
        assert(description != null);

  final String assetName;
  final String assetPackage;
  final String title;
  final List<String> description;

  bool get isValid => assetName != null && title != null && description?.length == 3;
}