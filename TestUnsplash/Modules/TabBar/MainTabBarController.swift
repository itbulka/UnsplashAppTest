//
//  MainTabBarController.swift
//  TestUnsplash
//
//  Created by Владимир Повальский on 20.06.2022.
//

import UIKit

var likesImages: [UnsplashModel] = [UnsplashModel]()

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.tintColor = .black
        self.tabBar.backgroundColor = .white
        
        let vc1 = UINavigationController(rootViewController: CollectionImageViewController())
        let vc2 = UINavigationController(rootViewController: ListFavoriteViewController())
        
        vc1.tabBarItem.title = "Изображения"
        vc2.tabBarItem.title = "Любимые изображения"
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "suit.heart.fill")
        
        setViewControllers([vc1, vc2], animated: true)
        
    }


}
