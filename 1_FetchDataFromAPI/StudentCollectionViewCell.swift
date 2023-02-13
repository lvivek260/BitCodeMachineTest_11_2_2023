//
//  StudentCollectionViewCell.swift
//  1_FetchDataFromAPI
//
//  Created by Admin on 11/02/23.
//

import UIKit

class StudentCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var image: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        image.layer.cornerRadius = 15
    }

}
