//
//  AboutViewController.swift
//  Car Machine
//
//  Created by Apple on 4/20/19.
//  Copyright © 2019 span4u. All rights reserved.
//

import UIKit

class AboutViewController: BaseViewController {
    @IBOutlet weak var about_description: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set text to the label
        about_description.text = "My Mechanic\n is working for the people of United States to get the mechanics at any time anywhere. People can get best mechanics at lowest price."
        
    }
    // back to home screen
    @IBAction func BackToPervious(_ sender: Any) {
        self.leftNavigationButtonPressed()
    }
    

}
