import 'package:flutter/material.dart';

import '00_base_page.dart';

class PaletteTabViewPage extends BasePage {
  PaletteTabViewPage({Key key, String title}) : super(key: key, title: title);

  @override
  _PaletteTabViewPageState createState() => _PaletteTabViewPageState();
}

class _PaletteTabViewPageState extends BasePageState<PaletteTabViewPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: allPalettes.length,
      child: buildBody(context),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0.0,
        bottom: TabBar(
          isScrollable: true,
          tabs: allPalettes.map((swatch) => Tab(text: swatch.name)).toList(),
        ),
      ),
      body: TabBarView(
        children: allPalettes.map((swatch) {
          return PaletteTabView(colors: swatch);
        }).toList(),
      ),
    );
  }
}

class PaletteTabView extends StatelessWidget {
  static const List<int> primaryKeys = [
    50,
    100,
    200,
    300,
    400,
    500,
    600,
    700,
    800,
    900
  ];
  static const List<int> accentKeys = [100, 200, 400, 700];

  final Palette colors;

  PaletteTabView({Key key, this.colors})
      : assert(colors != null && colors.isValid),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final whiteTextStyle = textTheme.body1.copyWith(color: Colors.white);
    final blackTextStyle = textTheme.body1.copyWith(color: Colors.black);

    final colorItems = primaryKeys.map((index) {
      return DefaultTextStyle(
        style: index > colors.threshold ? whiteTextStyle : blackTextStyle,
        child: ColorItem(index: index, color: colors.primary[index]),
      );
    }).toList();

    if (colors.accent != null) {
      colorItems.addAll(accentKeys.map((index) {
        return DefaultTextStyle(
          style: index > colors.threshold ? whiteTextStyle : blackTextStyle,
          child:
              ColorItem(index: index, color: colors.accent[index], prefix: 'A'),
        );
      }).toList());
    }

    // ListView 在竖屏模式下 padding 默认值为 MediaQuery.of(context).padding.copyWith(left: 0.0, top: 0.0, right: 0.0);
    return ListView(
      padding: EdgeInsets.only(bottom: 0.0),
      itemExtent: kColorItemHeight, // 如果不为 null, 将取代元素中指定的高度
      children: colorItems,
    );
  }
}

const double kColorItemHeight = 48.0;

class ColorItem extends StatelessWidget {
  final int index;
  final Color color;
  final String prefix;
  String get colorString =>
      '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';

  const ColorItem({
    Key key,
    @required this.index,
    @required this.color,
    this.prefix = '',
  })  : assert(index != null),
        assert(color != null),
        assert(prefix != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      child: Container(
        height: kColorItemHeight,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        color: color,
        child: SafeArea(
          left: true,
          top: false,
          right: true,
          bottom: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('$prefix$index'),
              Text(colorString),
            ],
          ),
        ),
      ),
    );
  }
}

class Palette {
  final String name;
  final MaterialColor primary;
  final MaterialAccentColor accent;
  final threshold;
  bool get isValid => name != null && primary != null && threshold != null;

  Palette(
      {@required this.name,
      @required this.primary,
      this.accent,
      this.threshold = 900});
}

final List<Palette> allPalettes = <Palette>[
  Palette(
    name: 'RED',
    primary: Colors.red,
    accent: Colors.redAccent,
    threshold: 300,
  ),
  Palette(
    name: 'PINK',
    primary: Colors.pink,
    accent: Colors.pinkAccent,
    threshold: 200,
  ),
  Palette(
    name: 'PURPLE',
    primary: Colors.purple,
    accent: Colors.purpleAccent,
    threshold: 200,
  ),
  Palette(
    name: 'DEEP PURPLE',
    primary: Colors.deepPurple,
    accent: Colors.deepPurpleAccent,
    threshold: 200,
  ),
  Palette(
    name: 'INDIGO',
    primary: Colors.indigo,
    accent: Colors.indigoAccent,
    threshold: 200,
  ),
  Palette(
    name: 'BLUE',
    primary: Colors.blue,
    accent: Colors.blueAccent,
    threshold: 400,
  ),
  Palette(
    name: 'LIGHT BLUE',
    primary: Colors.lightBlue,
    accent: Colors.lightBlueAccent,
    threshold: 500,
  ),
  Palette(
    name: 'CYAN',
    primary: Colors.cyan,
    accent: Colors.cyanAccent,
    threshold: 600,
  ),
  Palette(
    name: 'TEAL',
    primary: Colors.teal,
    accent: Colors.tealAccent,
    threshold: 400,
  ),
  Palette(
    name: 'GREEN',
    primary: Colors.green,
    accent: Colors.greenAccent,
    threshold: 500,
  ),
  Palette(
    name: 'LIGHT GREEN',
    primary: Colors.lightGreen,
    accent: Colors.lightGreenAccent,
    threshold: 600,
  ),
  Palette(
    name: 'LIME',
    primary: Colors.lime,
    accent: Colors.limeAccent,
    threshold: 800,
  ),
  Palette(
    name: 'YELLOW',
    primary: Colors.yellow,
    accent: Colors.yellowAccent,
  ),
  Palette(
    name: 'AMBER',
    primary: Colors.amber,
    accent: Colors.amberAccent,
  ),
  Palette(
    name: 'ORANGE',
    primary: Colors.orange,
    accent: Colors.orangeAccent,
    threshold: 700,
  ),
  Palette(
    name: 'DEEP ORANGE',
    primary: Colors.deepOrange,
    accent: Colors.deepOrangeAccent,
    threshold: 400,
  ),
  Palette(
    name: 'BROWN',
    primary: Colors.brown,
    threshold: 200,
  ),
  Palette(
    name: 'GREY',
    primary: Colors.grey,
    threshold: 500,
  ),
  Palette(
    name: 'BLUE GREY',
    primary: Colors.blueGrey,
    threshold: 500,
  ),
];