//
//  HomeViewController.swift
//  Car Machine
//
//  Created by Apple on 4/20/19.
//  Copyright © 2019 span4u. All rights reserved.
//

import UIKit
import CoreData
class HomeViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var arr_mechanic = [Mechanic]()
    
    @IBOutlet weak var coll_mechanic: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        // get all the register mechanics from the table
        let fetchRequest: NSFetchRequest<Mechanic> = Mechanic.fetchRequest()
        do {
            let resultss = try PersisServce.context.fetch(fetchRequest)
            self.arr_mechanic = resultss
            coll_mechanic.reloadData()
        } catch {}
    }
    // collection view delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr_mechanic.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let annotateCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MachineCollectionViewCell", for: indexPath) as! MachineCollectionViewCell
        // set text on the cell view
        annotateCell.lbl_name.text = arr_mechanic[indexPath.row].name
        annotateCell.lbl_type.text = arr_mechanic[indexPath.row].type_user
        annotateCell.lbl_adress.text = arr_mechanic[indexPath.row].address
        print(arr_mechanic[indexPath.row].name as Any)
        let myNSData = arr_mechanic[indexPath.row].profile_img! as NSData
        // Data to image convert
        let imagebase = UIImage(data: myNSData as Data)
        annotateCell.img_profile.image = imagebase
        // image round couner
        annotateCell.img_profile.layer.cornerRadius = annotateCell.img_profile.frame.size.width / 2
        annotateCell.img_profile.clipsToBounds = true
        annotateCell.btn_connect.addTarget(self, action: #selector(connectButtonTapped), for: .touchUpInside)
        annotateCell.btn_connect.tag = indexPath.row

        return annotateCell
    }
    // collection view cell adjust on the screen size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (coll_mechanic.frame.size.width - space) / 2.0
        return CGSize(width: size, height: 270)
    }
    // Tap any cell or select any cell perfom action here
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        
    }
    
    @IBAction func connectButtonTapped(_ sender: UIButton) {
        let sms1 = UserDefaults.standard.string(forKey: "user_info")
//        let strURL: String = sms!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//        UIApplication.shared.open(URL.init(string: strURL)!, options: [:], completionHandler: nil)

        let sms: String = "sms:"+arr_mechanic[sender.tag].phone!+"&body="+sms1!
        let strURL: String = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        UIApplication.shared.open(URL.init(string: strURL)!, options: [:], completionHandler: nil)
    }
    // move to the about screen
    @IBAction func aboutAction(_ sender: Any) {
        let moven = storyboard?.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
        self.navigationController?.pushViewController(moven, animated: true)
    }
    
    @IBAction func HomeToMove(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func outaction(_ sender: Any) {
        UserDefaults.standard.set("no", forKey: "user_login")
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
}
