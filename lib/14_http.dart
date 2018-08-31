import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '00_base_page.dart';

class HttpPage extends BasePage {
  HttpPage({Key key, String title}) : super(key: key, title: title);

  @override
  _HttpPageState createState() => _HttpPageState();
}

class _HttpPageState extends BasePageState<HttpPage> {
  @override
  Widget buildBody(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder<Post>(
//          future: _fetchPost(),
          future: http
            .get('https://jsonplaceholder.typicode.com/posts/1')
            .then((response) => Post.fromJson(json.decode(response.body))),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    snapshot.data.title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    snapshot.data.body,
                    style: Theme.of(context).textTheme.body1,
                  )
                ],
              );
            }

            if (snapshot.hasError) {
              return Text(
                snapshot.error.toString(),
                style: Theme.of(context).textTheme.body1.copyWith(color: Colors.red),
              );
            }

            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

class Post {
  Post({this.id, this.userId, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      body: json['body'],
    );
  }

  final int id;
  final int userId;
  final String title;
  final String body;
}

Future<Post> _fetchPost() async {
  final response = await http.get('https://jsonplaceholder.typicode.com/posts/1');
  return Post.fromJson(json.decode(response.body));
}