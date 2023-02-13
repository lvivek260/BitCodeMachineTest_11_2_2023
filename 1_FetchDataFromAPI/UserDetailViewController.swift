//
//  UserDetailViewController.swift
//  1_FetchDataFromAPI
//
//  Created by Admin on 13/02/23.
//

import UIKit
import SDWebImage
class UserDetailViewController: UIViewController {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var idNumber: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    
    var user:Datum?
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.text = user!.first_Name + " " + user!.last_Name
        idNumber.text = String(user!.id)
        userEmail.text = user!.email
        let url  = URL(string: user!.avatar)
        userImage.sd_setImage(with: url!)
        userImage.layer.cornerRadius = 50
    }

}
