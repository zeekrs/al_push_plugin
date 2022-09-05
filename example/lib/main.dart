import 'package:al_push_plugin/pusher_controller.dart';
import 'package:al_push_plugin/pusher_view.dart';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late PusherController pusherController;

  @override
  void initState() {
    super.initState();
    pusherController = PusherController(
        handleGetPushUrl: () {
          return Future.value("rtmp://push.tssjhb.com/test/test?auth_key=1660983721-0-0-f0618adb0d1479cf585a52f7623c84ba");
        },
        handleReconnectStart: () async {},
        handleError: (message) async {
          print("flutter 端:报错${message}");
        },
        handleConnectRecovery: () async {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Stack(
        children: [
          PusherView(controller: pusherController),
          Positioned(
            child: MaterialButton(
              onPressed: () {
                print("开始直播");
                pusherController.startPush(
                    "rtmp://push.tssjhb.com/test/test?auth_key=1660983721-0-0-f0618adb0d1479cf585a52f7623c84ba");
              },
              child: Text("开直播"),
              color: Colors.blue,
            ),
            left: 0,
            right: 0,
            bottom: 200,
            height: 40,
          ),
          // Positioned(
          //   child: MaterialButton(
          //     onPressed: () {
          //       print("关直播");
          //       pusherController.stopPush();
          //     },
          //     child: Text("关直播"),
          //     color: Colors.blue,
          //   ),
          //   left: 0,
          //   right: 0,
          //   top: 100,
          //   height: 40,
          // )
        ],
      ),
    );
  }
}
