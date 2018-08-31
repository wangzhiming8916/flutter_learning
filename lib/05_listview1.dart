import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '00_base_page.dart';
import 'shop.dart';

class SimpleListViewPage extends BasePage {
  SimpleListViewPage({Key key, String title}) : super(key: key, title: title);

  @override
  _SimpleListViewPageState createState() => _SimpleListViewPageState();
}

class _SimpleListViewPageState extends BasePageState<SimpleListViewPage> {
  final TextStyle _textStyle = const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 20.0
  );
  final Color _iconColor = Colors.blue[500];

  Future<List<List<Shop>>> _parseJson() async {
    await Future.delayed(Duration(milliseconds: 500));
    final jsonString = await rootBundle.loadString('res/shops.json');
    final jsonData = json.decode(jsonString) as List<dynamic>;
    return jsonData.map((shopsJsonData) {
      return (shopsJsonData as List<dynamic>).map((shopJsonData) {
        return Shop.fromJson(shopJsonData as Map<String, dynamic>);
      }).toList();
    }).toList();
  }

  List<Widget> _buildItems(List<List<Shop>> shopGroups) {
    final items = <Widget>[];
    for (int i = 0; i < shopGroups.length; i++) {
      final shops = shopGroups[i].map((shop) {
        return ListTile(
          title: Text(shop.name, style: _textStyle),
          subtitle: Text(shop.address),
          leading: Icon(
            IconData(shop.iconCode, fontFamily: "MaterialIcons"),
            color: _iconColor,
          ),
        );
      }).toList();

      items.addAll(shops);
      if (i < shops.length - 1) {
        items.add(Divider());
      }
    }
    return items;
  }

  @override
  Widget buildBody(BuildContext context) {
    return FutureBuilder<List<List<Shop>>>(
      future: _parseJson(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(children: _buildItems(snapshot.data));
        } else if(snapshot.hasError) {
          return Center(child: Text('Parse Json Error!'));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}