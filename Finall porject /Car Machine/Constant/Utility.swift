//
//  Utility.swift
//  Car Machine
//
//  Created by Apple on 4/20/19.
//  Copyright © 2019 span4u. All rights reserved.
//

import Foundation
import UIKit
import TSMessages
class Utility: NSObject {

    class func showAlertInController(controller : UIViewController , title : String!, subTitle: String, type : TSMessageNotificationType, callback: (() -> Void)){
        
        TSMessage.showNotification(in: controller, title: title, subtitle: subTitle, image: nil, type: type, duration: 3.0, callback: {
            
        }, buttonTitle: nil, buttonCallback: nil, at: TSMessageNotificationPosition.top, canBeDismissedByUser: true)
        
    }
    
    class func trimstring(str_text: String) -> String{
        let trimmed = str_text.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed
    }
    
    class func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
}
