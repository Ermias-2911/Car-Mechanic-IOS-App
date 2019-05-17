//
//  AdminViewController.swift
//  Car Machine
//
//  Created by Apple on 4/21/19.
//  Copyright © 2019 span4u. All rights reserved.
//

import UIKit
import CoreData
class AdminViewController: BaseViewController, UIImagePickerControllerDelegate,UIPopoverControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var txt_full_name: UITextField!
    @IBOutlet weak var txt_address_mechanic: UITextField!
    @IBOutlet weak var txt_phone_mechanic: UITextField!
    @IBOutlet weak var txt_mechanic_type: UITextField!
    @IBOutlet weak var img_user_mechanic: UIImageView!
    var picker:UIImagePickerController?=UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker?.delegate=self
        img_user_mechanic.layer.cornerRadius = img_user_mechanic.frame.size.width / 2
        img_user_mechanic.clipsToBounds = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(RegisterViewController.handleTap_register(_:)))
        tap.delegate = self as? UIGestureRecognizerDelegate // This is not required
        img_user_mechanic.addGestureRecognizer(tap)
        img_user_mechanic.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }
  
    @objc func handleTap_register(_ sender: UITapGestureRecognizer) {
        getImageFromGallery()
    }
    @IBAction func RegisterMechanicAction(_ sender: Any) {
        CheckData()
    }
    func ClearallField(){
        txt_full_name.text = EMPTY_STRING
        txt_mechanic_type.text = EMPTY_STRING
        txt_phone_mechanic.text = EMPTY_STRING
        txt_address_mechanic.text = EMPTY_STRING
    }
    func CheckData(){
        let f_name = self.removewhitespace(str_field_text: txt_full_name.text)
        let mechanic_type = self.removewhitespace(str_field_text: txt_mechanic_type.text)
        let phone_number = self.removewhitespace(str_field_text: txt_phone_mechanic.text)
        let address_mech = self.removewhitespace(str_field_text: txt_address_mechanic.text)
        if f_name == EMPTY_STRING{
            self.showErrorAlertWithMessage(message:  kerror_mg)
        }else if mechanic_type == EMPTY_STRING{
            self.showErrorAlertWithMessage(message:  kerror_mg)
        }
        else if phone_number == EMPTY_STRING{
            self.showErrorAlertWithMessage(message:  kerror_mg)
        }
        else if phone_number.count < 10 {
            self.showErrorAlertWithMessage(message:  kphone_mg)
        }
        else if address_mech == EMPTY_STRING{
            self.showErrorAlertWithMessage(message:  kerror_mg)
        }else{
            let data = img_user_mechanic.image!.pngData() as NSData?
            save(f_name: f_name, type_mechanic: mechanic_type, phone: phone_number, address: address_mech, img_user: data!)
            ClearallField()
        }
    }
    
    
    func save(f_name: String, type_mechanic : String, phone : String, address: String, img_user: NSData) {
        if #available(iOS 10.0, *) {
            let result = Mechanic(context: PersisServce.context)
            result.name = f_name
            result.type_user = type_mechanic
            result.phone = phone
            result.address = address
            result.profile_img = img_user as Data
            PersisServce.saveContext()
            self.alertShowWithMesg(mesg: "Mechanic successfully added in the list.")
        }
        
    }
   
    
    func getImageFromGallery(){
        openGallary()
    }
    func openGallary()
    {
        picker!.allowsEditing = false
        picker!.sourceType = UIImagePickerController.SourceType.photoLibrary
        present(picker!, animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage]
            as? UIImage else {
                return
        }
        
        img_user_mechanic.image = image
        dismiss(animated:true, completion: nil)
    }
    @IBAction func logoutAction(_ sender: Any) {
        UserDefaults.standard.set("no", forKey: "user_login")
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func backToHome(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    

}
