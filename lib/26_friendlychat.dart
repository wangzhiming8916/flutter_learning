import 'package:flutter/material.dart';

import '00_base_page.dart';

class FriendlyChatPage extends BasePage {
  FriendlyChatPage({Key key, String title}) : super(key: key, title: title);

  @override
  _FriendlyChatPageState createState() => _FriendlyChatPageState();
}

class _FriendlyChatPageState extends BasePageState<FriendlyChatPage>
    with TickerProviderStateMixin { // ignore: mixin_inherits_from_not_object
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _messages.forEach((message) => message.animationController.dispose());
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget buildBody(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _buildMessageList(),
          Divider(),
          _buildTextComposer(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return Flexible(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        controller: _scrollController,
        itemCount: _messages.length,
        itemBuilder: (context, index) => _messages[index],
      ),
    );
  }

  Widget _buildTextComposer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SafeArea(
        left: false,
        right: false,
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: InputDecoration.collapsed(hintText: 'Send a message'),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () => _handleSubmitted(_textController.text),
              ),
            )
          ],
        ),
      ),
    );
  }
  
  void _handleSubmitted(String text) {
    _textController.clear();
    final message = ChatMessage(
      text: text,
      animationController: AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this,
      ),
    );

    setState(() {
      _messages.add(message);
    });

    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
    message.animationController.forward();
  }
}

const String _name = 'Zhiming';

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.animationController});

  final String text;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      axisAlignment: 0.0,
      sizeFactor: CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              child: Text(_name[0]),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(_name, style: Theme.of(context).textTheme.subhead),
                  Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: Text(text),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

