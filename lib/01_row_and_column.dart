import 'package:flutter/material.dart';

import '00_base_page.dart';

class RowColumnPage extends BasePage {
  RowColumnPage({Key key, String title}) : super(key: key, title: title);

  @override
  _RowColumnPageState createState() => _RowColumnPageState();
}

class _RowColumnPageState extends BasePageState<RowColumnPage> {
  @override
  List<Widget> get actions => <Widget>[
    IconButton(
      icon: Icon(Icons.adjust, color: _isRow ? Colors.white : Colors.red),
      onPressed: () => setState(() => _isRow = !_isRow),
    ),
  ];

  bool _isRow = true;

  @override
  Widget buildBody(BuildContext content) {
    return _isRow ? _buildImagesRow() : _buildImagesColumn();
  }

  // Expanded 可以控制 Row 或 Column 的子组件在主轴方向上的大小，
  // 使用弹性系数 flex 属性控制子组件的权重，默认为1，
  // 所有子组件的 flex 相等时即均分主轴长度。
  // *** 当 Row 或 Column 中的子元素为 Expanded 时，mainAxisSize 和 mainAxisAlignment 失效。
  List<Widget> _imageWidgets() {
//    return <Widget>[
//      Image.asset('images/pic1.jpg', width: 50.0, height: 50.0, fit: BoxFit.cover),
//      Image.asset('images/pic2.jpg', width: 50.0, height: 50.0, fit: BoxFit.cover),
//      Image.asset('images/pic3.jpg', width: 50.0, height: 50.0, fit: BoxFit.cover),
//    ];
//    return <Widget>[
//      Image.asset('images/pic1.jpg', fit: BoxFit.cover),
//      Image.asset('images/pic2.jpg', fit: BoxFit.cover),
//      Image.asset('images/pic3.jpg', fit: BoxFit.cover),
//    ];
    return <Widget>[
      Expanded(child: Image.asset('images/pic1.jpg', fit: BoxFit.cover)),
      Expanded(child: Image.asset('images/pic2.jpg', fit: BoxFit.cover)),
      Expanded(child: Image.asset('images/pic3.jpg', fit: BoxFit.cover)),
    ];
  }

  // Container 的 alignment 不为 null 时将充满父组件
  Widget _buildImagesRow() {
    return Center(
      child: Container(
        color: Colors.red[100],
        padding: const EdgeInsets.all(12.0),
        child: Row(
//        mainAxisSize: MainAxisSize.max, // 行的宽度，max 为充满父组件，min 为包裹内容
//        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _imageWidgets(),
        ),
      ),
    );
  }

  Widget _buildImagesColumn() {
    return Center(
      child: Container(
        color: Colors.red[100],
        padding: const EdgeInsets.all(12.0),
        child: Column(
//        mainAxisSize: MainAxisSize.max, // 列的宽度，max 为充满父组件，min 为包裹内容
//        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _imageWidgets(),
        ),
      ),
    );
  }
}