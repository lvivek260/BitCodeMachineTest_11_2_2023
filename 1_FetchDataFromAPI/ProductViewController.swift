//
//  ProductViewController.swift
//  1_FetchDataFromAPI
//
//  Created by Admin on 11/02/23.
//

import UIKit
import SDWebImage

class ProductViewController: UIViewController {

    @IBOutlet weak var productTableView: UITableView!
    var products:[Productt] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        productTableView.delegate = self
        productTableView.dataSource = self
        let nib = UINib(nibName: "ProductTableViewCell", bundle: nil)
        productTableView.register(nib, forCellReuseIdentifier: "ProductTableViewCell")
        fetchData()
    }
  private func fetchData(){
        let url = URL(string: "https://dummyjson.com/products")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: request){
            data,response,error in
            if(error == nil){
                let jsonObject = try! JSONSerialization.jsonObject(with: data!) as! [String:Any]
                let product = jsonObject["products"] as! [[String:Any]]
                for i in product{
                    let id = i["id"] as! Int
                    let title = i["title"] as! String
                    let price = i["price"] as! Int
                    let rating = i["rating"] as! Double
                    let brand = i["brand"] as! String
                    let category = i["category"] as! String
                    let thumbnail = i["thumbnail"] as! String
                    let images = i["images"] as! [String]
                    let discountPercentage = i["discountPercentage"] as! Double
                    let newObj = Productt(id: id, title: title, price: price, rating: rating, brand: brand, category: category, thumbnail: thumbnail, images: images, discountPercentage:Float(discountPercentage))
                    self.products.append(newObj)
                }
               DispatchQueue.main.async {
                self.productTableView.reloadData()
               }
            }
            else{
                print("Please Check Internet")
            }
        }
        dataTask.resume()
    }

}

extension ProductViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productTableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as! ProductTableViewCell
        let obj = products[indexPath.row]
        cell.productTitle.text = obj.title
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: String(obj.price))
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
        cell.productPrice.attributedText = attributeString
        let discountInRs = Float(obj.discountPercentage/100)*Float(obj.price)
        let sellingPrice:Float = Float(obj.price) - discountInRs
        cell.productOffPrice.text = "₹"+String(Int(sellingPrice))
        cell.productPrice.text = "₹"+String(obj.price)
        cell.productRating.text = "Rating "+String(obj.rating)
        cell.productOffPercantage.text = String(Int(obj.discountPercentage)) + "% Off"
        cell.productOffPercantage.textColor = .green
        let urlString = obj.thumbnail
        let url  = URL(string: urlString)
        cell.productImage.sd_setImage(with: url)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailViewController") as! ProductDetailViewController
        productDetailViewController.obj = products[indexPath.row]
        self.navigationController?.pushViewController(productDetailViewController, animated: true)
    }
}
