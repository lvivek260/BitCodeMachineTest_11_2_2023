//
//  ProductDetailViewController.swift
//  1_FetchDataFromAPI
//
//  Created by Admin on 12/02/23.
//

import UIKit
import SDWebImage

class ProductDetailViewController: UIViewController {
    
    @IBOutlet weak var realProductPrice: UILabel!
    @IBOutlet weak var datailView: UIView!
    @IBOutlet weak var categary: UILabel!
    @IBOutlet weak var brand: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productRating: UILabel!
    @IBOutlet weak var productOffPercentage: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productPage: UIPageControl!
    @IBOutlet weak var productImagesCollectionView: UICollectionView!
    
    var obj:Productt?
    var images:[String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        images = obj!.images
        productImagesCollectionView.delegate = self
        productImagesCollectionView.dataSource = self
        let nib = UINib(nibName: "ProductDetailCollectionViewCell", bundle: nil)
        productImagesCollectionView.register(nib, forCellWithReuseIdentifier: "ProductDetailCollectionViewCell")
        productPage.currentPage = 0
        productPage.numberOfPages = images.count
        
        productTitle.text = obj?.title
        productRating.text = "  \(String(describing: obj!.rating))★ "
        productRating?.layer.cornerRadius = 10.0
        let discountInRs = Float(obj!.discountPercentage/100)*Float(obj!.price)
        let sellingPrice:Float = Float(obj!.price) - discountInRs
        productPrice.text = "₹" + String(Int(sellingPrice))
        productOffPercentage.text = String(Int(obj!.discountPercentage)) + "% off"
        priceView.layer.cornerRadius = 30
        datailView.layer.cornerRadius = 30
        categary.text = obj!.category
        brand.text = obj!.brand
        id.text = String(obj!.id)
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: "₹" + String(obj!.price))
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
        realProductPrice.attributedText = attributeString
    }
    
}
extension ProductDetailViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
            return 1
        }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = productImagesCollectionView.dequeueReusableCell(withReuseIdentifier: "ProductDetailCollectionViewCell", for: indexPath) as! ProductDetailCollectionViewCell
        let url  = URL(string: images[indexPath.row])
        cell.allProductImage.sd_setImage(with: url)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        productPage.currentPage = indexPath.row
    }
}

extension ProductDetailViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width
        return CGSize(width: width, height: 250)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}
