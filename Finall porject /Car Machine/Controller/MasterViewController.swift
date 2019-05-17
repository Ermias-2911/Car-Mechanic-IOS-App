//
//  MasterViewController.swift
//  Car Machine
//
//  Created by Apple on 4/25/19.
//  Copyright © 2019 span4u. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {

    @IBOutlet weak var btn_signup: UIButton!
    @IBOutlet weak var btn_move: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        btn_signup.isHidden = true
        let user_login = UserDefaults.standard.string(forKey: "user_login")
        if user_login == "yes"{
            btn_signup.isHidden = true
            btn_move.setTitle("Find Mechanic", for: .normal)
        }else if user_login == "yes_admin"{
            btn_signup.isHidden = true
            btn_move.setTitle("Add Mechanic", for: .normal)
        }else if user_login == "no"{
            btn_signup.isHidden = false
            btn_move.setTitle("Log in", for: .normal)
            btn_signup.setTitle("Sign up", for: .normal)
        }else{
            btn_signup.isHidden = false
            btn_move.setTitle("Log in", for: .normal)
            btn_signup.setTitle("Sign up", for: .normal)
        }
    }
    @IBAction func Movetopage(_ sender: Any) {
        let user_login = UserDefaults.standard.string(forKey: "user_login")
        if user_login == "yes"{
            MoveToHome()
        }else if user_login == "yes_admin"{
            MoveToadmin()
        }else if user_login == "no"{
            MoveTologin()
        }else{
            MoveTologin()
        }
    }
    // user home screen
    func MoveToHome() {
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
    // admin home screen
    func MoveTologin() {
        UserDefaults.standard.set("admin", forKey: "user_type")
        UserDefaults.standard.set("no", forKey: "user_login")
        let moven = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(moven, animated: true)
    }
    
    @IBAction func SignupAction(_ sender: Any) {
        let moven = storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        self.navigationController?.pushViewController(moven, animated: true)
    }
}
