import 'package:flutter/material.dart';

import '00_base_page.dart';

class ButtonsDemoPage extends BasePage {
  ButtonsDemoPage({Key key, String title}) : super(key: key, title: title);

  @override
  _ButtonsDemoPageState createState() => _ButtonsDemoPageState();
}

class _ButtonsDemoPageState extends BasePageState<ButtonsDemoPage> {
  ShapeBorder _buttonShape;
  ButtonThemeData _buttonTheme;
  List<ButtonTableView> _tableViews;

  List<Widget> get actions => <Widget>[
    IconButton(
      icon: const Icon(Icons.sentiment_very_satisfied),
      onPressed: () {
        setState(() {
          _buttonShape = _buttonShape == null ? const StadiumBorder() : null;
        });
      },
    ),
  ];

  Widget build(BuildContext context) {
    _buttonTheme = Theme.of(context).buttonTheme.copyWith(
      padding: const EdgeInsets.all(12.0),
      shape: _buttonShape,
    );
    _tableViews = _buildTableViews();
    return DefaultTabController(
      length: _tableViews.length,
      child: buildBody(context),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: actions,
        bottom: TabBar(
          isScrollable: true,
          tabs: _tableViews.map((tableView) => Tab(text: tableView.tabName)).toList(),
        ),
      ),
      body: TabBarView(children: _tableViews),
    );
  }

  List<ButtonTableView> _buildTableViews() {
    return <ButtonTableView>[
      ButtonTableView(
        tabName: 'RASIED',
        description: 'Raised buttons add dimension to mostly flat layouts. They emphasize functions on busy or wide spaces.',
        contentWidget: _buildRaisedButtons(),
        exampleCodeTag: 'buttons_raised',
      ),
      ButtonTableView(
        tabName: 'FLAT',
        description: 'A flat button displays an ink splash on press but does not lift. Use flat buttons on toolbars, in dialogs and inline with padding',
        contentWidget: _buildFlatButtons(),
        exampleCodeTag: 'buttons_flat',
      ),
      ButtonTableView(
        tabName: 'OUTLINE',
        description: 'Outline buttons become opaque and elevate when pressed. They are often paired with raised buttons to indicate an alternative, secondary action.',
        contentWidget: _buildOutlineButtons(),
        exampleCodeTag: 'buttons_outline',
      ),
      ButtonTableView(
        tabName: 'DROPDOWN',
        description: 'A dropdown button displays a menu that\'s used to select a value from a small set of values. The button displays the current value and a down ',
        contentWidget: _buildDropdownButtons(),
        exampleCodeTag: 'buttons_dropdown',
      ),
      ButtonTableView(
        tabName: 'ICON',
        description: 'IconButtons are appropriate for toggle buttons that allow a single choice to be selected or deselected, such as adding or removing an item\'s star.',
        contentWidget: _buildIconButtons(),
        exampleCodeTag: 'buttons_icon',
      ),
      ButtonTableView(
        tabName: 'ACTION',
        description: 'Floating action buttons are used for a promoted action. They are distinguished by a circled icon floating above the UI and can have motion behaviors that include morphing, launching, and a transferring anchor point.',
        contentWidget: _buildActionButtons(),
        exampleCodeTag: 'buttons_action',
      ),
    ];
  }

  Widget _buildRaisedButtons() {
    final buttonGroups = _buildButtonGroups(<Widget>[
      ButtonBar(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          RaisedButton(
            child: Text('RASIED BUTTON'),
            onPressed: () {},
          ),
          RaisedButton(
            child: Text('DISABLED'),
            onPressed: null,
          ),
        ],
      ),
      ButtonBar(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          RaisedButton.icon(
            icon: Icon(Icons.add),
            label: Text('RASED BUTTON'),
            onPressed: () {},
          ),
          RaisedButton.icon(
            icon: Icon(Icons.add),
            label: Text('DISABLED'),
            onPressed: null,
          ),
        ],
      ),
    ]);

    return FittedBox(
      alignment: Alignment.center,
      fit: BoxFit.scaleDown,
      child: ButtonTheme.fromButtonThemeData(
        data: _buttonTheme,
        child: buttonGroups,
      ),
    );
  }

  Widget _buildFlatButtons() {
    final buttonGroups = _buildButtonGroups(<Widget>[
      ButtonBar(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FlatButton(
            child: Text('RASIED BUTTON'),
            onPressed: () {},
          ),
          FlatButton(
            child: Text('DISABLED'),
            onPressed: null,
          ),
        ],
      ),
      ButtonBar(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.add_circle_outline),
            label: Text('RASED BUTTON'),
            onPressed: () {},
          ),
          FlatButton.icon(
            icon: Icon(Icons.add_circle_outline),
            label: Text('DISABLED'),
            onPressed: null,
          ),
        ],
      ),
    ]);

    return FittedBox(
      alignment: Alignment.center,
      fit: BoxFit.scaleDown,
      child: ButtonTheme.fromButtonThemeData(
        data: _buttonTheme,
        child: buttonGroups,
      ),
    );
  }

  Widget _buildOutlineButtons() {
    final buttonGroups = _buildButtonGroups(<Widget>[
      ButtonBar(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          OutlineButton(
            child: Text('RASIED BUTTON'),
            onPressed: () {},
          ),
          OutlineButton(
            child: Text('DISABLED'),
            onPressed: null,
          ),
        ],
      ),
      ButtonBar(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          OutlineButton.icon(
            icon: Icon(Icons.add),
            label: Text('RASED BUTTON'),
            onPressed: () {},
          ),
          OutlineButton.icon(
            icon: Icon(Icons.add),
            label: Text('DISABLED'),
            onPressed: null,
          ),
        ],
      ),
    ]);

    return FittedBox(
      alignment: Alignment.center,
      fit: BoxFit.scaleDown,
      child: ButtonTheme.fromButtonThemeData(
        data: _buttonTheme,
        child: buttonGroups,
      ),
    );
  }

  String _dropdown1Value = 'Free';
  String _dropdown2Value;
  String _dropdown3Value = 'Four';

  Widget _buildDropdownButtons() {
    return _buildButtonGroups(<Widget>[
      ListTile(
        title: const Text('Simple dropdown:'),
        trailing: DropdownButton<String>(
          value: _dropdown1Value,
          items: <String>['One', 'Two', 'Free', 'Four'].map((value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
          onChanged: (value) { setState(() => _dropdown1Value = value); },
        ),
      ),
      ListTile(
        title: const Text('Dropdown with a hint:'),
        trailing: DropdownButton<String>(
          value: _dropdown2Value,
          hint: Text('Choose'),
          items: <String>['One', 'Two', 'Free', 'Four'].map((value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
          onChanged: (value) { setState(() => _dropdown2Value = value); },
        ),
      ),
      ListTile(
        title: const Text('Scrollable dropdown:'),
        trailing: DropdownButton<String>(
          value: _dropdown3Value,
          isDense: false,
          items: <String>[
            'One', 'Two', 'Free', 'Four', 'Can', 'I', 'Have', 'A', 'Little',
            'Bit', 'More', 'Five', 'Six', 'Seven', 'Eight', 'Nine', 'Ten'
          ].map((value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
          onChanged: (value) { setState(() => _dropdown3Value = value); },
        ),
      )
    ]);
  }

  bool _iconButtonToggle = false;

  Widget _buildIconButtons() {
    return _buildButtonGroups(<Widget>[
      ButtonBar(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            width: 64.0,
            height: 64.0,
            child: IconButton(
              icon: Icon(Icons.thumb_up, color: _iconButtonToggle
                  ? Theme.of(context).primaryColor : null),
              onPressed: () { setState(() => _iconButtonToggle = !_iconButtonToggle); },
            ),
          ),
          SizedBox(
            width: 64.0,
            height: 64.0,
            child: IconButton(
              icon: Icon(Icons.thumb_up),
              onPressed: null,
            ),
          ),
        ],
      ),
    ]);
  }

  Widget _buildActionButtons() {
    return _buildButtonGroups(<Widget>[
      FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    ]);
  }

  Widget _buildButtonGroups(List<Widget> buttonGroups) {
    return Align(
      alignment: const Alignment(0.0, -0.2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: buttonGroups.map((buttonGroup) {
          return Container(
//            color: Colors.red[50],
            child: buttonGroup,
          );
        }).toList(),
      ),
    );
  }
}

class ButtonTableView extends StatelessWidget {
  final String tabName;
  final String description;
  final Widget contentWidget;
  final String exampleCodeTag;

  ButtonTableView({
    Key key,
    @required this.tabName,
    this.description,
    @required this.contentWidget,
    this.exampleCodeTag
  }) : assert(tabName != null),
        assert(contentWidget != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SafeArea(
            top: false,
            bottom: false,
            child: Text(
              description,
              style: Theme.of(context).textTheme.subhead.copyWith(color: Colors.black87),
            ),
          ),
          const SizedBox(height: 20.0),
          Expanded(child: contentWidget),
        ],
      ),
    );
  }
}