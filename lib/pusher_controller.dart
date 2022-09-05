import 'package:flutter/services.dart';

class PusherController {
  late MethodChannel _channel;
  Future<String> Function() handleGetPushUrl;
  Future Function(String message) handleError;
  Future Function() handleConnectRecovery;
  Future Function() handleReconnectStart;

  PusherController({required this.handleGetPushUrl,required this.handleError,required this.handleConnectRecovery,required this.handleReconnectStart});

  void onPlatformViewCreated(int viewId) {
    _channel = MethodChannel('dev.zeekrs.push/view_$viewId');
    _channel.setMethodCallHandler(handelCall);
  }

  Future<dynamic> handelCall(MethodCall methodCall) async {
    switch (methodCall.method) {
      case "getPushUrl":
        return handleGetPushUrl();
      case "error":
        return handleError(methodCall.arguments);
      case "connectRecovery":
        return handleConnectRecovery();
      case "reconnectStart":
        return handleReconnectStart();
    }
  }

  Future<int?> startPush(String url) {
    return _channel.invokeMethod<int?>("startPush", url);
  }


  Future<int?> stopPush() {
    return _channel.invokeMethod<int?>("stopPush");
  }



  Future<int?> showPanel() {
    return _channel.invokeMethod<int?>("showPanel");
  }


  Future<int?> dispose() {
    return _channel.invokeMethod<int?>("dispose");
  }


  Future<int?> pause() {
    return _channel.invokeMethod<int?>("pause");
  }


  Future<bool?> isPushing() {
    return _channel.invokeMethod<bool?>("isPushing");
  }


  Future<int?> resume() {
    return _channel.invokeMethod<int?>("resume");
  }


  Future<int?> stopPreview() {
    return _channel.invokeMethod<int?>("stopPreview");
  }
  Future<int?> startPreview() {
    return _channel.invokeMethod<int?>("startPreview");
  }
  Future<int?> switchCamera() {
    return _channel.invokeMethod<int?>("switchCamera");
  }
}
