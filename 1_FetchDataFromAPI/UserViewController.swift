//
//  ViewController.swift
//  1_FetchDataFromAPI
//
//  Created by Admin on 11/02/23.
//

import UIKit
import SDWebImage

class UserViewController: UIViewController {
   
    @IBOutlet weak var collectionView: UICollectionView!
    
    var students:[Datum] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .darkGray
        self.collectionView.backgroundColor = .black
        let nib = UINib(nibName: "StudentCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "StudentCollectionViewCell")
        fetchData()
    }
    
    func fetchData(){
        let url = URL(string: "https://reqres.in/api/users?page=2")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: request){
            data,response,error in
            if(error == nil){
                let jsonObject = try! JSONSerialization.jsonObject(with: data!) as! [String:Any]
                
                let data:[[String:Any]] = jsonObject["data"] as! [[String:Any]]

                for i in data{
                    let id = i["id"] as! Int
                   let email = i["email"] as! String
                   let firstN = i["first_name"] as? String
                   let lastN = i["last_name"] as? String
                   let avatar = i["avatar"] as! String
                    
                    let newObj = Datum(id: id, email: email, first_Name: firstN!, last_Name: lastN!, avatar: avatar)
                    self.students.append(newObj)
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            else{
                print("Please Check Internet")
            }
        }
        dataTask.resume()
    }
}

extension UserViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StudentCollectionViewCell", for: indexPath) as! StudentCollectionViewCell
        cell.fullName.text = students[indexPath.row].first_Name + " " + students[indexPath.row].last_Name
        cell.email.text = students[indexPath.row].email
        let urlString = students[indexPath.row].avatar
        let url  = URL(string: urlString)
        cell.image.sd_setImage(with: url)
        
        cell.layer.borderColor = .init(red: 1, green: 1, blue: 1, alpha: 0.8)
        cell.layer.cornerRadius = 15
        cell.layer.borderWidth = 1
        cell.backgroundColor = .darkGray
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return students.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "UserDetailViewController") as! UserDetailViewController
        userDetailViewController.user = students[indexPath.row]
        self.navigationController?.pushViewController(userDetailViewController, animated: true)
    }
}

extension UserViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.collectionView.bounds.width/2-3
        return CGSize(width: width, height: 350)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
}
