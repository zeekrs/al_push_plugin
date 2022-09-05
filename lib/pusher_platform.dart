import 'package:flutter/src/widgets/framework.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'pusher_method_channel.dart';

abstract class PusherPlatform extends PlatformInterface {
  /// Constructs a AlPushPluginPlatform.
  PusherPlatform() : super(token: _token);

  static final Object _token = Object();

  static PusherPlatform _instance = MethodChannelPusher();

  /// The default instance of [PusherPlatform] to use.
  ///
  /// Defaults to [MethodChannelAlPushPlugin].
  static PusherPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PusherPlatform] when
  /// they register themselves.
  static set instance(PusherPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

}
