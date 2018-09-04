import 'package:flutter_learning/app_themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '00_base_page.dart';
import '01_row_and_column.dart';
import '02_card1.dart';
import '03_card2.dart';
import '04_gridview.dart';
import '05_listview1.dart';
import '06_listview2.dart';
import '07_stack_avatar.dart';
import '08_contact_profile.dart';
import '09_buttons.dart';
import '10_appbar_bottom.dart';
import '11_listview3.dart';
import '12_shopping_list.dart';
import '13_listview4.dart';
import '14_http.dart';
import '15_animated_list.dart';
import '16_expansion_tile.dart';
import '17_scenic_spot_details.dart';
import '18_startup_namer.dart';
import '19_simple_animation.dart';
import '20_signature_painter.dart';
import '21_isolate.dart';
import '22_song_list.dart';
import '23_input_decoration.dart';
import '24_animated_logo.dart';
import '25_grow_transition.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 构建用于界面需要使用确定文本方向性的组建，但为了方便通常使用 MaterialApp
//    return Directionality(
//      textDirection: TextDirection.ltr,
//      child: Center(child: Text('Flutter Demo Home Page')),
//    );

    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightAppTheme.data,
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends BasePage {
  MyHomePage({Key key, String title}) : super(key: key, title: title);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends BasePageState<MyHomePage> {
  final List<BasePage> _routes = <BasePage>[
    RowColumnPage(title: 'Row, Column'),
    CardPage(title: 'Card1'),
    TravelDestinationPage(title: 'Card2'),
    GridViewPage(title: 'GridView'),
    SimpleListViewPage(title: 'ListView1'),
    PaletteTabViewPage(title: 'ListView2'),
    StackPage(title: 'Stack - Avatar'),
    ContactProfilePage(title: 'Contact Profile'),
    ButtonsDemoPage(title: 'Buttons Demo'),
    AppBarBottomSamplePage(title: 'AppBar Bottom'),
    ListView3Page(title: 'ListView3'),
    ShoppingListPage(title: 'Shopping List'),
    MessageListPage(title: 'Message List'),
    HttpPage(title: 'HTTP'),
    AnimatedListPage(title: 'Animated List'),
    ExpansionTilePage(title: 'Expansion Tile'),
    ScenicSpotDetailsPage(title: 'Scenic Spot Details'),
    RandomWordsPage(title: 'Startup Namer'),
    SimpleAnimationPage(title: 'Simple Animation'),
    SignaturePage(title: 'Signature Painter'),
    IsolateSamplePage(title: 'Isolate Sample'),
    SongListPage(title: 'Song List'),
    InputDecorationSamplePage(title: 'Input Decoration'),
    AnimatedLogoPage(title: 'Animated Logo'),
    GrowTransitionPage(title: 'Grow Transition'),
  ];
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    final drawer = Container(
      width: 260.0,
      color: Colors.white,
      alignment: Alignment.center,
      child: ListTile(
        leading: Icon(Icons.change_history),
        title: Text('Change history'),
        onTap: () {
          Navigator.pop(context); // close the drawer
        },
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      drawer: drawer,
      body: buildBody(context),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    final tiles = _routes.map((page) {
      return ListTile(
        title: Text(page.title, style: _biggerFont),
//        trailing: Icon(Icons.chevron_right),
        onTap: () =>
            Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
      );
    }).toList();
    final items = ListTile.divideTiles(context: context, tiles: tiles).toList();
    return ListView(children: items);
  }
}