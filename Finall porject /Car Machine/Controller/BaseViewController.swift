//
//  BaseViewController.swift
//  Car Machine
//
//  Created by Apple on 4/20/19.
//  Copyright © 2019 span4u. All rights reserved.
//

import UIKit
import TSMessages
class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showErrorAlertWithMessage(message:String!) {
        
        let msg = message
        
        if msg != nil {
            
            Utility.showAlertInController(controller: self, title: kAlertViewErrorTitle, subTitle: msg!, type: TSMessageNotificationType.error, callback: {})
        }
        else {
            
            Utility.showAlertInController(controller: self, title: kAlertViewErrorTitle, subTitle: message!, type: TSMessageNotificationType.error, callback: {})
        }
    }
    func alertShowWithMesg(mesg: String) {
        
        let alert = UIAlertController(title:nil, message:mesg, preferredStyle:.alert)
        
        let ok = UIAlertAction(title:"OK", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            
        })
        
        
        alert.addAction(ok)
        
        
        self.present(alert, animated: true, completion: nil)
    }
    func leftNavigationButtonPressed(){
        
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    func removewhitespace(str_field_text:String!) -> String{
        
        let text_field = Utility.trimstring(str_text: str_field_text)
        return text_field
    }
    func checkEmail(str_email:String) -> Bool {
        let text_field = Utility.isValidEmail(testStr: str_email)
        return text_field
    }
    
    func isPasswordValid(password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*\\d)(?=.*[a-z])[0-9a-zA-Z]{8,}$")
        return passwordTest.evaluate(with: password)
    }
}
