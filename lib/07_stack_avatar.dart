import 'package:flutter/material.dart';

import '00_base_page.dart';

class StackPage extends BasePage {
  StackPage({Key key, String title}) : super(key: key, title: title);

  @override
  _StackPageState createState() => _StackPageState();
}

class _StackPageState extends BasePageState<StackPage> {

  @override
  Widget buildBody(BuildContext context) {
    return Center(
      child: Container(
        width: 300.0,
        height: 300.0,
        color: Colors.red,
        child: Stack(
          alignment: Alignment(1.0, -1.0),
          children: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage('images/pic1.jpg'),
              radius: 100.0,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Text('Mia B',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}