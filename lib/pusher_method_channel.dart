import 'package:al_push_plugin/pusher_platform.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// An implementation of [AlPushPluginPlatform] that uses method channels.
const MethodChannel _channel = MethodChannel('dev.zeekrs.pusher/plugin');

class MethodChannelPusher extends PusherPlatform {

}
