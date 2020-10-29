//
//  MainTabBarController.swift
//  PhotosGallery
//
//  Created by Алим Куприянов on 21.09.2020.
//  Copyright © 2020 Алим Куприянов. All rights reserved.
//

import Foundation
import UIKit

class MainTabBarController : UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        
        
        let photosVC = PhotosCollectionVC(collectionViewLayout: UICollectionViewFlowLayout())
        let likesVC = LikesCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        
        
        
        viewControllers = [generateNavVC(rootViewController: photosVC, title: "Photos", image: #imageLiteral(resourceName: "Today-20")), generateNavVC(rootViewController: likesVC, title: "Favorites", image: #imageLiteral(resourceName: "For You-20")),
        
        ]
    }
    
    private func generateNavVC (rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }
}
