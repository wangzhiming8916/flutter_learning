import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '00_base_page.dart';

class MessageListPage extends BasePage {
  MessageListPage({Key key, String title}) : super(key: key, title: title);

  @override
  _MessageListPageState createState() => _MessageListPageState();
}

class _MessageListPageState extends BasePageState<MessageListPage> {
  @override
  Widget buildBody(BuildContext context) {
    final items = List<ListItem>.generate(30, (i) {
      return i % 6 == 0
          ? HeadingItem(heading: 'Heading $i')
          : MessageItem(sender: 'Sender $i', body: 'Message body $i');
    });

    return ListView.builder(
      itemCount: items.length,
      // Provide a builder function. This is where the magic happens! We'll
      // convert each item into a Widget based on the type of item it is.
      itemBuilder: (context, index) {
        final item = items[index];
        if (item is HeadingItem) {
          return ListTile(
            title: Text(
              item.heading,
              style: Theme.of(context).textTheme.headline,
            ),
          );
        } else if (item is MessageItem) {
          return ListTile(
            title: Text(item.sender),
            subtitle: Text(item.body),
          );
        }
      },
    );
  }
}

abstract class ListItem {}

class HeadingItem implements ListItem {
  HeadingItem({@required this.heading}) : assert(heading != null);

  final String heading;
}

class MessageItem implements ListItem {
  MessageItem({@required this.sender, @required this.body})
      : assert(sender != null),
        assert(body != null);

  final String sender;
  final String body;
}