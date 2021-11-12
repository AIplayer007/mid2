//
//  DetailViewController.swift
//  FoodPin
//
//  Created by NDHU_CSIE on 2021/11/8.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var restaurantImageView: UIImageView!

    var restaurantImageName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let string = restaurantImageName
        let replaced = (string as NSString).replacingOccurrences(of: ".png", with: "_photo.jpg")
        
        restaurantImageView.image = UIImage(named: replaced)
    }
    



}
