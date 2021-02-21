//
//  FlutterNativePlugin.swift
//  Runner
//
//  Created by HTC on 2021/2/20.
//

import Foundation
import StoreKit
import Flutter


class FlutterNativePlugin: NSObject  {
    static let shared = FlutterNativePlugin()
    private override init() {}
    
    var flutterController: FlutterViewController?
    
}

extension FlutterNativePlugin: FlutterPlugin{
    static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel.init(name: "iPomodoro", binaryMessenger: FlutterNativePlugin.shared.flutterController as! FlutterBinaryMessenger)
        let instance = FlutterNativePlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "requestReview" {
            if #available(iOS 10.3, *) {
                SKStoreReviewController.requestReview()
            }
            result("success")
            return
        }
        
        if call.method == "shareApp" {
            guard let arguments = call.arguments as? Dictionary<String, String> else {
                return
            }
            
            IAppleServiceUtil.shareWithImage(image: UIImage(named: "App-share-Icon")!, text: arguments["content"]!, url: arguments["url"]!, vc: FlutterNativePlugin.shared.flutterController!)
            result("success")
            return
        }
        
        if call.method == "email" {
            guard let arguments = call.arguments as? Dictionary<String, String> else {
                return
            }
            
            let message = "欢迎来信，写下你的问题吧\n\n\n\n" + kMarginLine + "\n 当前 \(arguments["appname"]!) 版本" + KAppVersion + "， 系统版本：" + String(Version.SYS_VERSION_FLOAT) + "， 设备信息：" + UIDevice.init().modelName
            let subject = "\(arguments["appname"]!) Feedback"
            ITCommonAPI.shared.sendEmail(recipients: [arguments["email"]!], subject: subject,  messae: message, vc: FlutterNativePlugin.shared.flutterController!)
            result("success")
            return
        }
        
        if call.method == "more" {
            let vc = ITAdvancelDetailViewController()
            vc.advancelType = .iHTCboyApp
            showNavigationController(title: "更多学习", vc: vc)
            result("success")
            return
        }
        
        if call.method == "version" {
            result(KAppVersion)
            return
        }
        
        if call.method == "timeZone" {
            result(TimeZone.current.identifier)
            return
        }
        
        if call.method == "badgeNumber" {
            guard let arguments = call.arguments as? Dictionary<String, Int> else {
                return
            }
            
            UIApplication.shared.applicationIconBadgeNumber = arguments["badgeNumber"]!
            result(UIApplication.shared.applicationIconBadgeNumber)
            return
        }
        
        result(FlutterMethodNotImplemented)
    }
    
    func showNavigationController(title: String, vc: UIViewController) {
        let navigationController = UINavigationController.init(rootViewController: vc)
        navigationController.navigationBar.topItem?.title = title;
        let rightSideOptionButton = UIBarButtonItem.init(barButtonSystemItem: .stop, target: self, action: #selector(closeVC))
        //UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(closeVC))
        navigationController.navigationBar.topItem?.rightBarButtonItem = rightSideOptionButton
        FlutterNativePlugin.shared.flutterController!.present(navigationController, animated: true, completion: nil)
    }
    
    @objc func closeVC() {
        FlutterNativePlugin.shared.flutterController!.dismiss(animated: true, completion: nil)
    }
}

/*
 @implementation FlutterNativePlugin

 + (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
     FlutterMethodChannel *channel = [FlutterMethodChannel methodChannelWithName:@"lianchu" binaryMessenger:[registrar messenger]];
     FlutterNativePlugin *instance = [[FlutterNativePlugin alloc]init];
     [registrar addMethodCallDelegate:instance channel:channel];
 }

 - (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
     if ([call.method isEqualToString:@"comeonman"]) {
         result(@"么么哒");
     }else {
         result(FlutterMethodNotImplemented);
     }
 }

 @end
 */
