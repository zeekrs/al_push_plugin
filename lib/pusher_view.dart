import 'package:al_push_plugin/types/resolution.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'pusher_controller.dart';

class PusherView extends StatelessWidget {
  final Widget? child;

  const PusherView(
      {Key? key,
      this.child,
      this.resolution = Resolution.resolution720P,
      required this.controller})
      : super(key: key);

  final Resolution resolution;

  final PusherController controller;

  @override
  Widget build(BuildContext context) {
    // This is used in the platform side to register the view.
    const String viewType = 'dev.zeekrs.pusher/view';
    // Pass parameters to the platform side.
    final Map<String, dynamic> creationParams = <String, dynamic>{};
    creationParams['resolution'] = resolution.name;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        // return widget on Android.
        return AndroidView(
          viewType: viewType,
          layoutDirection: TextDirection.ltr,
          creationParams: creationParams,
          creationParamsCodec: const StandardMessageCodec(),
          onPlatformViewCreated: controller.onPlatformViewCreated,
        );
      case TargetPlatform.iOS:
        return UiKitView(
            viewType: viewType,
            layoutDirection: TextDirection.ltr,
            creationParams: creationParams,
            creationParamsCodec: const StandardMessageCodec(),
            onPlatformViewCreated: controller.onPlatformViewCreated);
      // return widget on iOS.
      default:
        throw UnsupportedError('Unsupported platform view');
    }
  }
}
