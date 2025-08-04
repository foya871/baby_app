/*
 * @Author: zi_qi
 * @Date: 2024-07-19 19:44:59
 * @LastEditors: wdz
 * @LastEditTime: 2025-06-27 20:15:27
 * @Description: 
 */

// import 'package:flutter/foundation.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_proxy/shelf_proxy.dart';
import 'package:collection/collection.dart';

//前端页面访问本地域名
// ignore: constant_identifier_names
const String localHost = 'localhost';
//前端页面访问本地端口号
// ignore: constant_identifier_names
const int agentPort = 5268;
// String realHttpURL = 'http://118.107.45.22:8301';
String realHttpURL = 'https://abc.m9h9o5o5z.work';
//cd ./libs/env   dart run porxy.dart
Future main(List<String> args) async {
  String? host;
  int? port;
  for (final pair in args.slices(2)) {
    if (pair.length != 2) continue;
    final key = pair[0];
    final value = pair[1];
    if (key == '-h' || key == '--host') {
      host = value;
    } else if (key == '-p' || key == '--port') {
      port = int.tryParse(value);
    }
  }

  host ??= localHost;
  port ??= agentPort;

  handler(Request request) async {
    if (request.method == 'OPTIONS') {
      return Response.ok('', headers: {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Headers': '*',
        'Access-Control-Allow-Methods': '*',
        'Access-Control-Allow-Credentials': 'true',
      });
    }
    return proxyHandler(realHttpURL)(request);
  }

  var server = await shelf_io.serve(
    handler,
    host,
    port,
  );
  server.defaultResponseHeaders.add('Access-Control-Allow-Origin', '*');
  server.defaultResponseHeaders.add('Access-Control-Allow-Headers', '*');
  server.defaultResponseHeaders.add('Access-Control-Allow-Methods', '*');
  server.defaultResponseHeaders.add('Access-Control-Allow-Credentials', true);

  print('Serving at http://${server.address.host}:${server.port}');
}
