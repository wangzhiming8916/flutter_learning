import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '00_base_page.dart';

class ListView3Page extends BasePage {
  ListView3Page({Key key, String title}) : super(key: key, title: title);

  @override
  _ListView3PageState createState() => _ListView3PageState();
}

class _ListView3PageState extends BasePageState<ListView3Page> {
  final items = List.generate(20, (index) => index);

  @override
  Widget buildBody(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => _buildItem(context, index),
      itemCount: items.length,
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    return Dismissible(
      key: Key('$index'),
      onDismissed: (direction) {
        items.removeAt(index);
        print('items count: ${items.length}');
        Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('$index dismissed')),
        );
      },
      background: Container(
        margin: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(const Radius.circular(4.0))
        ),
      ),
      child: SafeArea(
        top: false,
        bottom: false,
        child: Container(
          margin: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(const Radius.circular(4.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(color: Colors.black26, blurRadius: 8.0),
            ],
          ),
          child: FlatButton(
            onPressed: () => print("点击了哦"),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "这是一点描述，这是一点描述，这是一点描述，这是一点描述，这是一点描述",
                    style: TextStyle(color: Colors.grey, fontSize: 14.0),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      _buildBottomButton(Icons.star, "1000"),
                      _buildBottomButton(Icons.link, "1000"),
                      _buildBottomButton(Icons.subject, "1000"),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildBottomButton(IconData icon, String text) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(icon, size: 16.0, color: Colors.grey),
          SizedBox(width: 5.0),
          Text(
            text,
            style: TextStyle(color: Colors.grey, fontSize: 14.0),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}