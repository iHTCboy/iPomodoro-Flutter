//
//  ITCommonAPI.swift
//  iTalker
//
//  Created by HTC on 2017/4/23.
//  Copyright © 2017年 ihtc.cc @iHTCboy. All rights reserved.
//

import UIKit
import MessageUI


class ITCommonAPI: NSObject {
    
    static let shared = ITCommonAPI()
    private override init() {} //This prevents others from using the default '()' initializer for this class.
    
}

// update
extension ITCommonAPI
{
   
}

extension ITCommonAPI : MFMailComposeViewControllerDelegate
{
    func sendEmail(recipients: Array<String>, subject: String, messae: String, vc: UIViewController) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(recipients)
            mail.setSubject(subject)
            mail.setMessageBody(messae, isHTML: false)
            vc.present(mail, animated: true, completion: nil)
        } else {
            // show failure alert
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
