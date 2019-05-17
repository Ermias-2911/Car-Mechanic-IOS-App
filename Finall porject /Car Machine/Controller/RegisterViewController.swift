//
//  RegisterViewController.swift
//  Car Machine
//
//  Created by Apple on 4/20/19.
//  Copyright © 2019 span4u. All rights reserved.
//

import UIKit
import CoreData
class RegisterViewController: BaseViewController, UIImagePickerControllerDelegate,UIPopoverControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var lbl_det: UILabel!
    @IBOutlet weak var txt_f_name: UITextField!
    @IBOutlet weak var txt_email: UITextField!
    @IBOutlet weak var txt_phone: UITextField!
    @IBOutlet weak var txt_password: UITextField!
    @IBOutlet weak var img_user: UIImageView!
    @IBOutlet weak var txt_confirm: UITextField!
    @IBOutlet weak var txt_address: UITextField!
    
    var picker:UIImagePickerController?=UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set the text on the label
        lbl_det.text = "You are aggreed to our terms and conditions.\nYou will get the best mechanics from Untied States"
        // image picker delegate
        picker?.delegate=self
        // image round corner
        img_user.layer.cornerRadius = img_user.frame.size.width / 2
        img_user.clipsToBounds = true
        // set action on the image view
        let tap = UITapGestureRecognizer(target: self, action: #selector(RegisterViewController.handleTap_register(_:)))
        tap.delegate = self as? UIGestureRecognizerDelegate
        img_user.addGestureRecognizer(tap)
        img_user.isUserInteractionEnabled = true
    }
    // imageview tap action menthod
    @objc func handleTap_register(_ sender: UITapGestureRecognizer) {
        getImageFromGallery()
    }
    // Register action
    @IBAction func RegisterAction(_ sender: Any) {
        CheckData()
    }
    // Back button action
    @IBAction func backToPervious(_ sender: Any) {
        self.leftNavigationButtonPressed()
        
    }
    // check the validation field empty or not
    func CheckData(){
        let address_user = self.removewhitespace(str_field_text: txt_address.text)
        let f_name = self.removewhitespace(str_field_text: txt_f_name.text)
        let email = self.removewhitespace(str_field_text: txt_email.text)
        let email_bool = self.checkEmail(str_email: txt_email.text!)
        let phone_number = self.removewhitespace(str_field_text: txt_phone.text)
        let password = self.removewhitespace(str_field_text: txt_password.text)
        let confirm_password = self.removewhitespace(str_field_text: txt_confirm.text)
        let password_bool = self.isPasswordValid(password: password)
        if f_name == EMPTY_STRING{
            self.showErrorAlertWithMessage(message:  kerror_mg)
        }else if email == EMPTY_STRING{
            self.showErrorAlertWithMessage(message:  kerror_mg)
        }
        else if !email_bool{
            self.showErrorAlertWithMessage(message:  kemail_validation_mg)
        }
        else if phone_number == EMPTY_STRING{
            self.showErrorAlertWithMessage(message:  kerror_mg)
        }
        else if phone_number.count < 10 {
            self.showErrorAlertWithMessage(message:  kphone_mg)
        }
        else if password == EMPTY_STRING{
            self.showErrorAlertWithMessage(message:  kerror_mg)
        }else if password != confirm_password{
            self.showErrorAlertWithMessage(message:  kpassword_mg)
        }
        else if !password_bool{
            self.showErrorAlertWithMessage(message:  kpassword_length_mg)
        }
        else if address_user == EMPTY_STRING{
            self.showErrorAlertWithMessage(message:  kerror_mg)
        }
        else{
            let data = img_user.image!.pngData() as NSData?
            let imageStr = data?.base64EncodedString(options: .lineLength64Characters) ?? ""
            save(f_name: f_name, email: email, phone: phone_number, password_str: password, img_user: imageStr, user_address: address_user)
        }
    }
    // save data into the user table
    func save(f_name: String, email : String, phone : String, password_str: String, img_user: String, user_address: String) {
        if #available(iOS 10.0, *) {
            let result = User(context: PersisServce.context)
            result.f_name = f_name
            result.email = email
            result.phone = phone
            result.password = password_str
            result.img_profile = img_user
            result.address = user_address
            PersisServce.saveContext()
            let user_info = "Hi My name is "+f_name+"I need your help Contact on my phone number "+phone+" Here my location "+user_address+" http://maps.apple.com/?q="+user_address
            UserDefaults.standard.set(user_info, forKey: "user_info")
             MoveToHome()
            self.alertShowWithMesg(mesg: "Account successfully register welcome " + f_name)
           
        }
        
    }
    // move to the user home screen
    func MoveToHome() {
        UserDefaults.standard.set("user", forKey: "user_type")
        UserDefaults.standard.set("yes", forKey: "user_login")
        let moven = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(moven, animated: true)
    }
    
    func getImageFromGallery(){
       openGallary()
    }
    // open gallery of your phone
    func openGallary()
    {
        picker!.allowsEditing = false
        picker!.sourceType = UIImagePickerController.SourceType.photoLibrary
        present(picker!, animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    // image picker delegate 
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage]  
            as? UIImage else {
                return
        }
        
        img_user.image = image
        dismiss(animated:true, completion: nil)
    }
    
    
}
