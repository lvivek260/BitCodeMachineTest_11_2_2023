//
//  ProductTableViewCell.swift
//  1_FetchDataFromAPI
//
//  Created by Admin on 11/02/23.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productOffPrice: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productRating: UILabel!
    @IBOutlet weak var productOffPercantage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
