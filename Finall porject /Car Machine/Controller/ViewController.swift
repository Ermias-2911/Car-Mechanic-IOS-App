//
//  ViewController.swift
//  Car Machine
//
//  Created by Apple on 4/20/19.
//  Copyright © 2019 span4u. All rights reserved.
//

import UIKit
import CoreData
class ViewController: BaseViewController {
    @IBOutlet weak var lbl_account_register: UILabel!
    var arr_res = [User]()
    @IBOutlet weak var txt_password: UITextField!
    @IBOutlet weak var txt_email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        //set the action on the register label
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTap(_:)))
        tap.delegate = self as? UIGestureRecognizerDelegate // This is not required
        lbl_account_register.addGestureRecognizer(tap)
        lbl_account_register.isUserInteractionEnabled = true
    }
    // Login button action perform
    @IBAction func LoginAction(_ sender: Any) {
        // check the validation field empty or not
        let email = self.removewhitespace(str_field_text: txt_email.text)
        let email_bool = self.checkEmail(str_email: txt_email.text!)
        let password = self.removewhitespace(str_field_text: txt_password.text)
        if email == EMPTY_STRING{
            self.showErrorAlertWithMessage(message:  kerror_mg)
        }
        else if !email_bool{
            self.showErrorAlertWithMessage(message:  kemail_validation_mg)
        }
        else if password == EMPTY_STRING{
            self.showErrorAlertWithMessage(message:  kerror_mg)
        }
        else{
            // if you want to go admin side
            if email == "admin@admin.com" && password == "123456"{
                //
                MoveToadmin()
            }else{
                var name_user = ""
                var phone_user = ""
                var address_user = ""
                // get all the user from the user table
                var check_user = ""
                let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
                do {
                    let resultss = try PersisServce.context.fetch(fetchRequest)
                    self.arr_res = resultss
                    for i in self.arr_res{
                        name_user = i.f_name!
                        phone_user = i.phone!
                        address_user = i.address!
                       
                        if i.email == email && i.password == password {
                            // go to the user home screen
                            check_user = "move"
                            break
                        }else{
                            check_user = ""
                        }
                    }
                    if check_user == "move"
                    {
                        MoveToHome(str_name_user: name_user, str_user_phone: phone_user, str_address: address_user)
                    }else{
                        self.alertShowWithMesg(mesg: "Please enter correct email and password.")
                    }
                } catch {}
            }
        }
    }
    // register tap action
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        let moven = storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        self.navigationController?.pushViewController(moven, animated: true)
    }
    // user home screen
    func MoveToHome(str_name_user: String, str_user_phone: String, str_address: String) {
        let user_info = "Hi My name is "+str_name_user+" I need your help Contact on my phone number "+str_user_phone+" Here my location "+str_address+" http://maps.apple.com/?q="+str_address
        UserDefaults.standard.set(user_info, forKey: "user_info")
        UserDefaults.standard.set("user", forKey: "user_type")
        UserDefaults.standard.set("yes", forKey: "user_login")
        let moven = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(moven, animated: true)
    }
    // admin home screen
    func MoveToadmin() {
        UserDefaults.standard.set("admin", forKey: "user_type")
        UserDefaults.standard.set("yes_admin", forKey: "user_login")
        let moven = storyboard?.instantiateViewController(withIdentifier: "AdminViewController") as! AdminViewController
        self.navigationController?.pushViewController(moven, animated: true)
    }
    @IBAction func MoveToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

