import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '00_base_page.dart';

class IsolateSamplePage extends BasePage {
  IsolateSamplePage({Key key, String title}) : super(key: key, title: title);

  @override
  _IsolateSamplePageState createState() => _IsolateSamplePageState();
}

class _IsolateSamplePageState extends BasePageState<IsolateSamplePage> {
  @override
  Widget buildBody(BuildContext context) {
    return FutureBuilder<dynamic>(
//      future: http
//          .get('https://jsonplaceholder.typicode.com/posts')
//          .then((response) => json.decode(response.body)),
      future: _loadData(), // 在独立执行线程中运行 isolate
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final posts = snapshot.data as List;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Row ${posts[index]['title']}'),
            ),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text(
                snapshot.error.toString(),
                style: Theme.of(context).textTheme.body1.copyWith(color: Colors.red[900]),
              ),
            ),
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Future<dynamic> _loadData() async {
    ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(_dataLoader, receivePort.sendPort);
    return await receivePort.first;
  }

  static _dataLoader(SendPort callerSendPort) async {
    http.Response response = await http.get('https://jsonplaceholder.typicode.com/posts');
    callerSendPort.send(json.decode(response.body));
  }

  // 下面的例子稍显繁琐，但是很好展示了 isolate 的用法
//  Future<dynamic> _loadData() async {
//    ReceivePort receivePort = ReceivePort(); // _loadData.ReceivePort
//
//    print('_loadData ~ _loadData.ReceivePort : ${receivePort.hashCode}');
//    print('_loadData ~ _loadData.ReceivePort.SendPort: ${receivePort.sendPort.hashCode}');
//
//    await Isolate.spawn(_dataLoader, receivePort.sendPort); // _loadData.ReceivePort.SendPort
//    SendPort dataLoaderSendPort = await receivePort.first; // _dataLoader.ReceivePort.SendPort
//
//    print('_loadData ~ _dataLoader.ReceivePort.SendPort: ${dataLoaderSendPort.hashCode}');
//
//    return await _sendReceive(dataLoaderSendPort, 'https://jsonplaceholder.typicode.com/posts');
//  }
//
//  static _dataLoader(SendPort callerSendPort) async { // _loadData.ReceivePort.SendPort
//    print('  _dataLoader ~ _loadData.ReceivePort.SendPort: ${callerSendPort.hashCode}');
//
//    ReceivePort receivePort = ReceivePort(); // _dataLoader.ReceivePort
//    print('  _dataLoader ~ _dataLoader.ReceivePort: ${receivePort.hashCode}');
//    print('  _dataLoader ~ _dataLoader.ReceivePort.SendPort: ${receivePort.sendPort.hashCode}');
//
//    callerSendPort.send(receivePort.sendPort); // _dataLoader.ReceivePort.SendPort
//
//    await for (final msg in receivePort) {
//      String url = msg[0];
//      SendPort replyTo = msg[1];
//
//      print('  _dataLoader ~ _sendReceive.ReceivePort.SendPort: ${replyTo.hashCode}');
//
//      http.Response response = await http.get(url);
//      replyTo.send(json.decode(response.body));
//    }
//  }
//
//  Future<dynamic> _sendReceive(SendPort dataLoaderSendPort, msg) async { // _dataLoader.ReceivePort.SendPort
//    print('    _sendReceive ~ _dataLoader.ReceivePort.SendPort: ${dataLoaderSendPort.hashCode}');
//
//    ReceivePort receivePort = ReceivePort(); // _sendReceive.ReceivePort
//    print('    _sendReceive ~ _sendReceive.ReceivePort: ${receivePort.sendPort.hashCode}');
//    print('    _sendReceive ~ _sendReceive.ReceivePort.SendPort: ${receivePort.sendPort.hashCode}');
//
//    dataLoaderSendPort.send([msg, receivePort.sendPort]); // _sendReceive.ReceivePort.SendPort
//
//    return await receivePort.first;
//  }
}