import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    // flutter与原生桥接
    let controller = self.window.rootViewController as! FlutterViewController
    FlutterNativePlugin.shared.flutterController = controller
    FlutterNativePlugin.register(with: self.registrar(forPlugin: "FlutterNativePlugin")!)
    
    //push
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self
    }
    
    // flutter插件通道代理
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

//
//FlutterViewController* controller =
//(FlutterViewController*)self.window.rootViewController;
//FlutterMethodChannel* channel =
//[FlutterMethodChannel methodChannelWithName:@"io.baizi.flutter_open_native"
//                            binaryMessenger:controller];
//[channel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
//  if ([@"open_webview" isEqualToString:call.method]) { // 修改了方法名
//    UIViewController *vc = [[UIViewController alloc] init]; // 使用最简单的viewcontroller
//    vc.view.backgroundColor = [UIColor whiteColor]; // 不设置背景颜色，会出现空白，并且掉帧情
//    UINavigationController* navigationController =
//    [[UINavigationController alloc] initWithRootViewController:vc];
//    navigationController.navigationBar.topItem.title = @"浏览器";
//    [controller presentViewController:navigationController animated:YES completion:nil];// 增加动画，否则不容易看出来变化
//  } else {
//    result(FlutterMethodNotImplemented);
//  }
//}];
