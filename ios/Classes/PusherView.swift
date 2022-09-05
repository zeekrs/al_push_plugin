//
//  PusherView.swift
//  al_push_plugin
//
//  Created by zeekrs on 2022/8/19.
//

import Foundation
class PusherViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }
    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
           return FlutterStandardMessageCodec.sharedInstance()
    }
    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return PusherView(
            frame:  UIScreen.main.bounds,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger)
    }
}

class PusherView: NSObject, FlutterPlatformView,AlivcLivePusherInfoDelegate,AlivcLivePusherErrorDelegate,AlivcLivePusherNetworkDelegate,AlivcLivePusherBGMDelegate,AlivcLivePusherCustomFilterDelegate,AlivcLivePusherCustomDetectorDelegate, AlivcLivePusherSnapshotDelegate{
    func onStarted(_ pusher: AlivcLivePusher!) {
        print("bgm started")
    }
    
    func onStoped(_ pusher: AlivcLivePusher!) {
        print("bgm stoped")
    }
    
    func onPaused(_ pusher: AlivcLivePusher!) {
        print("bgm paused")
    }
    
    func onResumed(_ pusher: AlivcLivePusher!) {
        print("bgm resumed")
    }
    
    func onProgress(_ pusher: AlivcLivePusher!, progress: Int, duration: Int) {
        print("bgm progress")
    }
    
    func onCompleted(_ pusher: AlivcLivePusher!) {
        print("bgm completed")
    }
    
    func onOpenFailed(_ pusher: AlivcLivePusher!) {
        print("bgm open failed")
    }
    
    func onDownloadTimeout(_ pusher: AlivcLivePusher!) {
        print("bgm download timeout")
    }
    
    func onCreate(_ pusher: AlivcLivePusher!, context: UnsafeMutableRawPointer!) {
        
    }
    
    func updateParam(_ pusher: AlivcLivePusher!, buffing: Float, whiten: Float, pink: Float, cheekpink: Float, thinface: Float, shortenface: Float, bigeye: Float) {
        
    }
    
    func `switch`(on pusher: AlivcLivePusher!, on: Bool) {
        
    }
    
    func onProcess(_ pusher: AlivcLivePusher!, texture: Int32, textureWidth width: Int32, textureHeight height: Int32, extra: Int) -> Int32 {
        if (self.beautyOn)
        {
            return AlivcBeautyController.sharedInstance().processGLTexture(withTextureID: texture, withWidth: width, withHeight: height)
        }
        return texture
    }
    
    func onDestory(_ pusher: AlivcLivePusher!) {
        AlivcBeautyController.sharedInstance().destroy()
    }
    
    func onCreateDetector(_ pusher: AlivcLivePusher!) {
        
    }
    
    func onDetectorProcess(_ pusher: AlivcLivePusher!, data: Int, w: Int32, h: Int32, rotation: Int32, format: Int32, extra: Int) -> Int {
        
        if (self.beautyOn)
        {
            
            AlivcBeautyController.sharedInstance().detectVideoBuffer(data, withWidth: w, withHeight: h, with: self._config.externVideoFormat, with: self._config.orientation)
          
        }
        return data;
    }
    
    func onDestoryDetector(_ pusher: AlivcLivePusher!) {
        
    }
    
    func onSnapshot(_ pusher: AlivcLivePusher!, image: UIImage!) {
        print("on snapshot")
    }
        
    func onSystemError(_ pusher: AlivcLivePusher!, error: AlivcLivePushError!) {
        print("on system error")
        _channel.invokeMethod("error", arguments: "on system error");
    }
    
    func onSDKError(_ pusher: AlivcLivePusher!, error: AlivcLivePushError!) {
        print("on sdk error")
        _channel.invokeMethod("error", arguments: "on sdk error");

    }
    
    func onNetworkPoor(_ pusher: AlivcLivePusher!) {
        print("on network poor")
        _channel.invokeMethod("error", arguments: "on network poor");

    }
    
    func onConnectFail(_ pusher: AlivcLivePusher!, error: AlivcLivePushError!) {
        print("on connect fail")
        _channel.invokeMethod("error", arguments: "on connect fail");

    }
    
    func onConnectRecovery(_ pusher: AlivcLivePusher!) {
        print("on connect recovery")
        _channel.invokeMethod("connectRecovery", arguments: "on connect recovery");


    }
    
    func onReconnectStart(_ pusher: AlivcLivePusher!) {
        print("on reconnect start")
        _channel.invokeMethod("reconnectStart", arguments: "on reconnect start");

    }
    
    func onReconnectSuccess(_ pusher: AlivcLivePusher!) {
        print("on reconnect success")
        
    }
    
    func onConnectionLost(_ pusher: AlivcLivePusher!) {
        print("on connection lost")
        _channel.invokeMethod("error", arguments: "on connection lost");
    }
    
    func onReconnectError(_ pusher: AlivcLivePusher!, error: AlivcLivePushError!) {
        print("on reconnect time out")
        _channel.invokeMethod("error", arguments: "on reconnect time out");

    }
    
    func onSendDataTimeout(_ pusher: AlivcLivePusher!) {
        print("send data timeout")
        _channel.invokeMethod("error", arguments: "send data timeout");

    }
   
    func onPushURLAuthenticationOverdue(_ pusher: AlivcLivePusher!) -> String! {
        if(pusher.isPushing()){
             print("on Auth push url update")
            _channel.invokeMethod("getPushUrl", arguments: nil) { result in
                self.pushUrl =  result as? String;
            }
        }
        return self.pushUrl
    }
    
    func onSendSeiMessage(_ pusher: AlivcLivePusher!) {
        print("send message")
        _channel.invokeMethod("error", arguments: "send message");

    }
    
    private var _view: UIView
    private var _livePusher :AlivcLivePusher
    private var beautyOn = true
    private var _config : AlivcLivePushConfig
    private var _channel : FlutterMethodChannel
    private var pushUrl : String?;
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger
    ) {
        
        
        _config = AlivcLivePushConfig.init()
        if let params = args as? Dictionary<String, Any>,
           let resolution = params["resolution"] as? String{
            _config.resolution = resolution.toResolution()
        }
        
        _config.fps = .FPS20
        _config.enableAutoBitrate = true
        _config.enableAutoResolution = true
        _config.previewDisplayMode = .ALIVC_LIVE_PUSHER_PREVIEW_ASPECT_FIT
        
        _livePusher = AlivcLivePusher.init(config: _config)
        _view = UIView(frame: frame)
        _channel = FlutterMethodChannel.init(name: "dev.zeekrs.push/view_\(viewId)", binaryMessenger: messenger)
        super.init()
        _channel.setMethodCallHandler { call, result in
            switch (call.method){
            case "startPush":
                let url =  call.arguments as! String
                self.pushUrl = url
                let res = self._livePusher.startPush(withURL: url)
                print("res = \(res)")
                result(res)
            case "stopPush":
                let res =  self._livePusher.stopPush()
                result(res)
            case "showPanel":
                AlivcBeautyController.sharedInstance().showPanel(true)
            case "dispose":
                self._livePusher.destory();
            case "pause":
                self._livePusher.pause();
            case "isPushing":
                result(self._livePusher.isPushing());
            case "resume":
                self._livePusher.resume();
            case "stopPreview":
                self._livePusher.stopPreview();
            case "startPreview":
                self._livePusher.startPreview(self._view);
            case "switchCamera":
                self._livePusher.switchCamera();
          
            default:
                break
            }
        }
        _livePusher.setInfoDelegate(self)
        _livePusher.setErrorDelegate(self)
        _livePusher.setNetworkDelegate(self)
        _livePusher.setBGMDelegate(self)
        _livePusher.setSnapshotDelegate(self)
        _livePusher.setCustomFilterDelegate(self)
        _livePusher.setCustomDetectorDelegate(self)
        // iOS views can be created here
        createNativeView(view: _view)
    }

    

    func view() -> UIView {
        return _view
    }

    func createNativeView(view _view: UIView){
        
        _livePusher.startPreview(_view)
//        let button = UIButton(type: .custom)
//        button.frame = CGRect(x: 100,y: 80, width: 40, height: 40)
//           button.layer.cornerRadius = 0.5 * button.bounds.size.width
//           button.clipsToBounds = true
////        let button = UIButton.init(frame: CGRect.init(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 40))
////        button.titleLabel.font=[UIFont systemFontOfSize:12];
//        button.titleLabel?.font = UIFont(name: "", size: 10)
//        button.setTitle("美颜", for: .normal)
//        button.backgroundColor = UIColor(red: 0x13/255, green: 0x1b/255, blue: 0x33/255, alpha: 1)
//        _view.addSubview(button)
//        button.addGestureRecognizer(UITapGestureRecognizer(target: self,action: #selector(onBeautyClick)))
//
        if(self.beautyOn){
            AlivcBeautyController.sharedInstance().setupBeautyController()
            AlivcBeautyController.sharedInstance().setupBeautyControllerUI(with: self._view)
        }
    }
    
    @objc
    func onBeautyClick(){
        AlivcBeautyController.sharedInstance().showPanel(true)
        print("on beauty click")
        
    }
    
    
}
