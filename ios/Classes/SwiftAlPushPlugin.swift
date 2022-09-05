import Flutter
import UIKit

@available(iOS 10.0, *)
public class SwiftAlPushPlugin: NSObject, FlutterPlugin {
    
    
  private let registry: FlutterTextureRegistry

  private let channel: FlutterMethodChannel
    
  private var pusherView: PusherView?
    
  private var textureId : Int64?
    
    init(channel: FlutterMethodChannel, registry: FlutterTextureRegistry) {
        self.channel = channel
        self.registry = registry
    }
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    
    let channel = FlutterMethodChannel(name: "dev.zeekrs.pusher/plugin", binaryMessenger: registrar.messenger())
      let instance = SwiftAlPushPlugin.init(channel: channel, registry: registrar.textures())
    registrar.addMethodCallDelegate(instance, channel: channel)
      let factory = PusherViewFactory.init(messenger: registrar.messenger())
      registrar.register(factory, withId: "dev.zeekrs.pusher/view")
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      switch call.method{
      default:
          break
      }
  }
}
