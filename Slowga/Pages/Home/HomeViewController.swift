//
//  HomeViewController.swift
//  Slowga
//
//  Created by Deshun Cai on 8/10/18.
//  Copyright © 2018 Unusep Productions. All rights reserved.
//

import UIKit

class HomeViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    
    func setup() {
        // nav bar styling
        self.navigationBar.prefersLargeTitles = true
        
        // collections view
        let libraryCollectionViewController = UICollectionViewController(
            collectionViewLayout: UICollectionViewFlowLayout()
        )
        libraryCollectionViewController.collectionView.backgroundColor = .yellow
        libraryCollectionViewController.title = "Library"
        
        self.setViewControllers([libraryCollectionViewController], animated: false)
        
    }

}
